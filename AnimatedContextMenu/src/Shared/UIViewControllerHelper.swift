//
//  UIViewControllerHelper.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 27.01.2022.
//

import UIKit.UIViewController

extension UIViewController {
    class func instantiateFromStoryboard(_ name: String, viewController: String? = nil) -> UIViewController {
        let viewControllerName: String = viewController != nil ? viewController! : name
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerName)
        return viewController
    }
}
