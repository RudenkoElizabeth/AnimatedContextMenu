//
//  ContextMenuConfigurator.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

import UIKit

class ContextMenuModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? ContextMenuViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: ContextMenuViewController) {

        let router = ContextMenuRouter()

        let presenter = ContextMenuPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = ContextMenuInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
