//
//  ContextMenuPresenter.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

class ContextMenuPresenter: ContextMenuModuleInput, ContextMenuViewOutput, ContextMenuInteractorOutput{

    weak var view: ContextMenuViewInput!
    var interactor: ContextMenuInteractorInput!
    var router: ContextMenuRouterInput!

    func viewIsReady() {

    }
}
