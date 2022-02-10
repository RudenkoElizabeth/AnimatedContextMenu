//
//  MainInterfaceRouter.swift
//
//  Created by Rudenko Elizabeth on 10/02/2022.
//

import UIKit

class MainInterfaceRouter: MainInterfaceRouterInput {

    weak var view: MainInterfaceViewController!
    
    func showContextMenu() {
        let identifier = MainInterfaceConstants.contextMenuIdentifier
        let viewController = UIViewController.instantiateFromStoryboard(identifier) as! ContextMenuViewController
        let presenter = ContextMenuModuleConfigurator().configureModuleForViewInput(viewInput: viewController, moduleOutput: self)
        view.present(viewController, animated: false, completion: {
            presenter?.showContextMenu()
        })
    }
}

extension MainInterfaceRouter: ContextMenuModuleOutput {
    func actionFor(item: MenuItem) {
        print("action for \(item.title)")
    }
}
