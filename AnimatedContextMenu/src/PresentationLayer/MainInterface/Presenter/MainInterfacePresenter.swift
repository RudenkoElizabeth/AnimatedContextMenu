//
//  MainInterfacePresenter.swift
//
//  Created by Rudenko Elizabeth on 10/02/2022.
//

class MainInterfacePresenter: MainInterfaceModuleInput, MainInterfaceViewOutput {
    
    weak var view: MainInterfaceViewInput!
    var router: MainInterfaceRouterInput!
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func showContextMenu() {
        router.showContextMenu()
    }
}
