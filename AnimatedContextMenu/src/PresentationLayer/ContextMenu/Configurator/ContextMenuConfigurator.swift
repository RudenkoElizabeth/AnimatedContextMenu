//
//  ContextMenuConfigurator.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

import UIKit

class ContextMenuModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, moduleOutput: ContextMenuModuleOutput) -> ContextMenuModuleInput? {
        if let viewController = viewInput as? ContextMenuViewController {
            return configure(viewController: viewController, moduleOutput: moduleOutput)
        }
        return nil
    }
    
    private func configure(viewController: ContextMenuViewController, moduleOutput: ContextMenuModuleOutput) -> ContextMenuModuleInput {
        
        let presenter = ContextMenuPresenter()
        presenter.view = viewController
        presenter.moduleOutput = moduleOutput
        
        viewController.output = presenter
        
        return presenter
    }
    
}
