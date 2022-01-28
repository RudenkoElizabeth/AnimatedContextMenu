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
    private var currentState: ContextMenuConstants.State = .closed
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: ContextMenuViewInput
    func setupInitialState() {
        
    }
    
    func showContextMenu() {
        animateContextMenu()
    }
    
    // Action
    @IBAction private func dismissAction() {
        animateContextMenu() {
            self.dismiss(animated: false)
        }
    }
    
    // Animation
    private func animateContextMenu(completion: @escaping (() -> Void) = {} ) {
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = -460
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .end:
                self.currentState = state
                completion()
            default:
                self.currentState = state.opposite
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = -460
            }
        }
        transitionAnimator.startAnimation()
    }
}


