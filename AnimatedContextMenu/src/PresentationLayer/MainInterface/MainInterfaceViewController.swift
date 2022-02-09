//
//  MainInterfaceViewController.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 27.01.2022.
//

import UIKit

class MainInterfaceViewController: UIViewController {
    
    @IBOutlet private weak var contextMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension MainInterfaceViewController {
    @IBAction func showContextMenuAction() {
        let identifier = "ContextMenu"
        let viewController = UIViewController.instantiateFromStoryboard(identifier) as! ContextMenuViewController
        let presenter = ContextMenuModuleConfigurator().configureModuleForViewInput(viewInput: viewController, moduleOutput: self)
        present(viewController, animated: false, completion: {
            presenter?.showContextMenu()
        })
    }
}

extension MainInterfaceViewController: ContextMenuModuleOutput {
    func actionFor(item: MenuItem) {
        print("action for \(item.title)")
    }
}
