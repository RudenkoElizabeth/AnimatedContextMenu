//
//  ContextMenuProtocols.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

protocol ContextMenuViewInput: AnyObject {
    func setupInitialState()
}

protocol ContextMenuViewOutput {
    func viewIsReady()
}

protocol ContextMenuModuleInput: AnyObject {

}

protocol ContextMenuInteractorInput {

}

protocol ContextMenuInteractorOutput: AnyObject {

}

protocol ContextMenuRouterInput {

}
