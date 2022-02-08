//
//  ContextMenuProtocols.swift
//
//  Created by Rudenko Elizabeth on 27/01/2022.
//

protocol ContextMenuViewInput: AnyObject {
    func setupInitialState()
    func showContextMenu()
    func hideContextMenu()
}

protocol ContextMenuViewOutput {
    func viewIsReady()
    func getTitleFor(row: Int) -> String
    func getIconFor(row: Int) -> String
    func actionFor(row: Int)
}

protocol ContextMenuModuleInput: AnyObject {
    func showContextMenu()
}

protocol ContextMenuModuleOutput: AnyObject {
    func actionFor(item: MenuItem)
}
