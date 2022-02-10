//
//  ContextMenuViewController.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

import UIKit

class ContextMenuViewController: UIViewController, ContextMenuViewInput {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var contextMenuView: UIView!
    @IBOutlet private weak var topHeight: NSLayoutConstraint!
    @IBOutlet private weak var contextMenuHeight: NSLayoutConstraint!
    @IBOutlet private weak var contextMenuBottom: NSLayoutConstraint!
    
    var output: ContextMenuViewOutput!
    // For animation
    private var conttextMenuOffset: CGFloat = 0
    private var animationProgress: CGFloat = 0
    private var currentState: ContextMenuConstants.State = .closed
    private var runningAnimator: UIViewPropertyAnimator?
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    private let animationDuration: TimeInterval = 0.5
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func setupInitialState() {
        let safeAreaBottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
        let tableViewHegight = tableView.rowHeight * CGFloat(ContextMenuConstants.menuItems.count)
        conttextMenuOffset = tableViewHegight + topHeight.constant + safeAreaBottom
        contextMenuHeight.constant = conttextMenuOffset
        contextMenuBottom.constant = conttextMenuOffset
        contextMenuView.addGestureRecognizer(panRecognizer)
    }
    
    func showContextMenu() {
        animateTransitionIfNeeded(to: .open, duration: animationDuration)
    }
    
    func hideContextMenu() {
        animateTransitionIfNeeded(to: .closed, duration: 0.2)
    }
}

// Actions
private extension ContextMenuViewController {
    @IBAction func dismissAction() {
        hideContextMenu()
    }
    
    @objc func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animationBegan(recognizer)
        case .changed:
            animationChanged(recognizer)
        case .ended:
            animationEnded(recognizer)
        default:
            return
        }
    }
}

// MARK: - Animation
private extension ContextMenuViewController {
    // Animates the transition, if the animation is not already running
    func animateTransitionIfNeeded(to state: ContextMenuConstants.State, duration: TimeInterval) {
        guard runningAnimator == nil else { return }
        runningAnimator = getAnimatorFor(state: state, duration: duration)
        setupCompletionFor(state: state)
        runningAnimator?.startAnimation()
    }
    
    func getAnimatorFor(state: ContextMenuConstants.State, duration: TimeInterval) -> UIViewPropertyAnimator {
        UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.contextMenuBottom.constant = 0
                self.contextMenuView.layer.cornerRadius = 20
                self.contextMenuView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                self.view.backgroundColor = .black.withAlphaComponent(0.5)
            case .closed:
                self.contextMenuBottom.constant = self.conttextMenuOffset
                self.contextMenuView.layer.cornerRadius = 0
                self.view.backgroundColor = .clear
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func setupCompletionFor(state: ContextMenuConstants.State) {
        runningAnimator?.addCompletion { [self] position in
            runningAnimator = nil
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            default:
                return
            }
            switch self.currentState {
            case .open:
                self.contextMenuBottom.constant = 0
            case .closed:
                self.contextMenuBottom.constant = self.conttextMenuOffset
                self.dismiss(animated: false)
            }
        }
    }
    
    func animationBegan(_ recognizer: UIPanGestureRecognizer) {
        animateTransitionIfNeeded(to: currentState.opposite, duration: animationDuration)
        guard let runningAnimator = self.runningAnimator else { return }
        runningAnimator.pauseAnimation()
        animationProgress = runningAnimator.fractionComplete
    }
    
    func animationChanged(_ recognizer: UIPanGestureRecognizer) {
        guard let runningAnimator = self.runningAnimator else { return }
        let translation = recognizer.translation(in: contextMenuView)
        var fraction = -translation.y / conttextMenuOffset
        let isAdjustFraction = currentState == .open || runningAnimator.isReversed
        if isAdjustFraction { fraction *= -1 }
        runningAnimator.fractionComplete = fraction + animationProgress
    }
    
    func animationEnded(_ recognizer: UIPanGestureRecognizer) {
        guard let runningAnimator = self.runningAnimator else { return }
        let yVelocity = recognizer.velocity(in: contextMenuView).y
        if yVelocity != 0 {
            let isReversed = runningAnimator.isReversed
            let shouldClose = yVelocity > 0
            let needToggle: Bool = {
                switch currentState {
                case .open: return shouldClose == isReversed
                case .closed: return shouldClose != isReversed
                }
            }()
            if needToggle { runningAnimator.isReversed.toggle() }
        }
        runningAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }
}
