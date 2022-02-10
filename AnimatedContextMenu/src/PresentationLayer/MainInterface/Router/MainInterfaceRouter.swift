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
        let title = item.title
        let message =  MainInterfaceConstants.alertMessage
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionTitle = MainInterfaceConstants.alertActionTitle
        let alertAction = UIAlertAction(title: actionTitle, style: .default)
        alert.addAction(alertAction)
        view.present(alert, animated: true)
    }
}
