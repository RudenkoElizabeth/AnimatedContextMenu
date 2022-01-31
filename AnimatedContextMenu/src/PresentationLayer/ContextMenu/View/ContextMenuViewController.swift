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
        let menuHeight = tableView.rowHeight * CGFloat(ContextMenuConstants.titles.count)
        contextMenuHeight.constant = menuHeight + topHeight.constant
        contextMenuBottom.constant = menuHeight
        conttextMenuOffset = menuHeight
        contextMenuView.addGestureRecognizer(panRecognizer)
    }
    
    func showContextMenu() {
        animateTransitionIfNeeded(to: .open)
    }
    
    @objc private func tabBackgroundAction() {
        animateTransitionIfNeeded(to: .closed)
    }
    
    // Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: ContextMenuConstants.State) {
        guard runningAnimator == nil else { return }
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.contextMenuBottom.constant = 0
                self.contextMenuView.layer.cornerRadius = 20
                self.view.backgroundColor = .black.withAlphaComponent(0.5)
            case .closed:
                self.contextMenuBottom.constant = self.conttextMenuOffset
                self.contextMenuView.layer.cornerRadius = 0
                self.view.backgroundColor = .clear
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { [self] position in
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
        transitionAnimator.startAnimation()
        runningAnimator = transitionAnimator
    }
    
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(to: currentState.opposite)
            runningAnimator?.pauseAnimation()
            animationProgress = runningAnimator?.fractionComplete ?? 0
        case .changed:
            let translation = recognizer.translation(in: contextMenuView)
            var fraction = -translation.y / conttextMenuOffset
            let isAdjustFraction = currentState == .open || runningAnimator?.isReversed == true
            if isAdjustFraction { fraction *= -1 }
            runningAnimator?.fractionComplete = fraction + animationProgress
        case .ended:
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
        default:
            return
        }
    }
}
