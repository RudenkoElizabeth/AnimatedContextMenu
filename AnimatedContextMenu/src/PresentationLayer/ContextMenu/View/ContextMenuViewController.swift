//
//  ContextMenuViewController.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

import UIKit

class ContextMenuViewController: UIViewController, ContextMenuViewInput {

    var output: ContextMenuViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    // MARK: ContextMenuViewInput
    func setupInitialState() {
    }
}
