//
//  MainInterfaceProtocols.swift
//
//  Created by Rudenko Elizabeth on 10/02/2022.
//

protocol MainInterfaceViewInput: AnyObject {
    func setupInitialState()
}

protocol MainInterfaceViewOutput {
    func viewIsReady()
    func showContextMenu()
}

protocol MainInterfaceModuleInput: AnyObject {
    
}

protocol MainInterfaceRouterInput {
    func showContextMenu()
}
