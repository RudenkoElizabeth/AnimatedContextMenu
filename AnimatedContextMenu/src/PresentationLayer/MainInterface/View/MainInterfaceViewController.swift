//
//  MainInterfaceViewController.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 27.01.2022.
//

import UIKit

class MainInterfaceViewController: UIViewController, MainInterfaceViewInput {
    
    @IBOutlet private weak var contextMenuView: UIView!
    
    var output: MainInterfaceViewOutput!
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        MainInterfaceModuleConfigurator().configureModuleForViewInput(viewInput: self)
    }
    
    // MARK: MainInterfaceViewInput
    func setupInitialState() {
    }
}

private extension MainInterfaceViewController {
    @IBAction func showContextMenuAction() {
        output.showContextMenu()
    }
}
