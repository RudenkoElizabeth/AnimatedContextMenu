//
//  ViewController.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

private extension ViewController {
    @IBAction func showContextMenuAction() {
        let identifier = "ContextMenu"
        let viewController = UIViewController.instantiateFromStoryboard(identifier) as! ContextMenuViewController
        let presenter = ContextMenuModuleConfigurator().configureModuleForViewInput(viewInput: viewController)
        present(viewController, animated: false, completion: {
            presenter?.showContextMenu()
        })
    }
}
