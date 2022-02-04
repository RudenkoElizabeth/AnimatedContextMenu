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
    private var conttextMenuOffset: CGFloat = 0
    private var currentState: ContextMenuConstants.State = .closed
    private var runningAnimator: UIViewPropertyAnimator?
    private var animationProgress: CGFloat = 0
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    func setupInitialState() {
        let menuHeight = tableView.rowHeight * CGFloat(ContextMenuConstants.menuItems.count)
        contextMenuHeight.constant = menuHeight + topHeight.constant
        contextMenuBottom.constant = menuHeight
        conttextMenuOffset = menuHeight
        contextMenuView.addGestureRecognizer(panRecognizer)
    }
    
    func showContextMenu() {
        animateTransitionIfNeeded(to: .open)
    }
}

private extension ContextMenuViewController {
    @IBAction func dismissAction() {
        animateTransitionIfNeeded(to: .closed)
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

// Animates the transition, if the animation is not already running
private extension ContextMenuViewController {
    func animateTransitionIfNeeded(to state: ContextMenuConstants.State) {
        guard runningAnimator == nil else { return }
        runningAnimator = getAnimatorFor(state: state)
        setupCompletionFor(state: state)
        runningAnimator?.startAnimation()
    }
    
    func getAnimatorFor(state: ContextMenuConstants.State) -> UIViewPropertyAnimator {
        UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
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
        animateTransitionIfNeeded(to: currentState.opposite)
        runningAnimator?.pauseAnimation()
        animationProgress = runningAnimator?.fractionComplete ?? 0
    }
    
    func animationChanged(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: contextMenuView)
        var fraction = -translation.y / conttextMenuOffset
        let isAdjustFraction = currentState == .open || runningAnimator?.isReversed == true
        if isAdjustFraction { fraction *= -1 }
        runningAnimator?.fractionComplete = fraction + animationProgress
    }
    
    func animationEnded(_ recognizer: UIPanGestureRecognizer) {
        let yVelocity = recognizer.velocity(in: contextMenuView).y
        guard yVelocity != 0 else {
            runningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            return
        }
        let shouldClose = yVelocity > 0
        if let isReversed = runningAnimator?.isReversed {
            switch currentState {
            case .open:
                if !shouldClose && !isReversed { runningAnimator?.isReversed.toggle() }
                if shouldClose && isReversed { runningAnimator?.isReversed.toggle() }
            case .closed:
                if shouldClose && !isReversed { runningAnimator?.isReversed.toggle() }
                if !shouldClose && isReversed { runningAnimator?.isReversed.toggle() }
            }
        }
        runningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }
}
