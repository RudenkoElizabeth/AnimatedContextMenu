//
//  MainInterfaceProtocols.swift
//
//  Created by Rudenko Elizabeth on 10/02/2022.
//

protocol MainInterfaceViewInput: class {
    func setupInitialState()
}

protocol MainInterfaceViewOutput {
    func viewIsReady()
}

protocol MainInterfaceModuleInput: class {

}

protocol MainInterfaceRouterInput {

}
