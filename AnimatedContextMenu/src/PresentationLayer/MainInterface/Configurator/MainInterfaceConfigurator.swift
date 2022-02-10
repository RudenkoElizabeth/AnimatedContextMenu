//
//  MainInterfaceModuleConfigurator.swift
//
//  Created by Rudenko Elizabeth on 10/02/2022.
//

import UIKit

class MainInterfaceModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? MainInterfaceViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: MainInterfaceViewController) {
        
        let router = MainInterfaceRouter()
        router.view = viewController
        
        let presenter = MainInterfacePresenter()
        presenter.view = viewController
        presenter.router = router
        
        viewController.output = presenter
    }
    
}
