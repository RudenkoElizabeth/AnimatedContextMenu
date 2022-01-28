//
//  ContextMenuViewController.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

import UIKit

class ContextMenuViewController: UIViewController, ContextMenuViewInput {
    
    @IBOutlet private weak var contextMenuView: UIView!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    
    var output: ContextMenuViewOutput!
    private let popupOffset: CGFloat = 460
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
        contextMenuView.addGestureRecognizer(panRecognizer)
    }
    
    func showContextMenu() {
        animateTransitionIfNeeded(to: .open)
    }
    
    /// Animates the transition, if the animation is not already running.
    private func animateTransitionIfNeeded(to state: ContextMenuConstants.State) {
        
        // ensure that the animators array is empty (which implies new animations need to be created)
        guard runningAnimator == nil else { return }
        
        // an animator for the transition
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.contextMenuView.layer.cornerRadius = 20
                self.view.backgroundColor = .black.withAlphaComponent(0.5)
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
                self.contextMenuView.layer.cornerRadius = 0
                self.view.backgroundColor = .clear
            }
            self.view.layoutIfNeeded()
        })
        
        // the transition completion block
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
            // manually reset the constraint positions
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
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
            
            // variable setup
            let translation = recognizer.translation(in: contextMenuView)
            var fraction = -translation.y / popupOffset
            
            // adjust the fraction for the current state and reversed state
            if currentState == .open { fraction *= -1 }
            if runningAnimator?.isReversed == true { fraction *= -1 }
            runningAnimator?.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: contextMenuView).y
            let shouldClose = yVelocity > 0
            
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                runningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            
            if let isReversed = runningAnimator?.isReversed {
                switch currentState {
                case .open:
                    if !shouldClose && !isReversed { runningAnimator?.isReversed = !isReversed }
                    if shouldClose && isReversed { runningAnimator?.isReversed = !isReversed }
                case .closed:
                    if shouldClose && !isReversed { runningAnimator?.isReversed = !isReversed }
                    if !shouldClose && isReversed { runningAnimator?.isReversed = !isReversed }
                }
            }
            runningAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }
}
