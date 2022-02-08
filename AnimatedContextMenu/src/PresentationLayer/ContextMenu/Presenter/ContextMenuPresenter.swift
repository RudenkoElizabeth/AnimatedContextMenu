//
//  ContextMenuPresenter.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

class ContextMenuPresenter: ContextMenuModuleInput, ContextMenuViewOutput {
    
    weak var view: ContextMenuViewInput!
    weak var moduleOutput: ContextMenuModuleOutput!
    private let menuItems = ContextMenuConstants.menuItems
    
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func showContextMenu() {
        view.showContextMenu()
    }
    
    func getTitleFor(row: Int) -> String {
        menuItems[row].title
    }
    
    func getIconFor(row: Int) -> String {
        menuItems[row].title
    }
    
    func actionFor(row: Int) {
        let item = menuItems[row]
        moduleOutput.actionFor(item: item)
        view.hideContextMenu()
    }
}
