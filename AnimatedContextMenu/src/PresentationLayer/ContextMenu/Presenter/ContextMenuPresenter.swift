//
//  ContextMenuPresenter.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

class ContextMenuPresenter: ContextMenuModuleInput, ContextMenuViewOutput {
    
    weak var view: ContextMenuViewInput!
    weak var moduleOutput: ContextMenuModuleOutput!
    private let menuItems = ContextMenuConstants.menuItems
    private var selectedItem: MenuItem?
    
    deinit {
        if let item = selectedItem {
            moduleOutput.actionFor(item: item)
        }
    }
    
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
        selectedItem = menuItems[row]
        view.hideContextMenu()
    }
}
