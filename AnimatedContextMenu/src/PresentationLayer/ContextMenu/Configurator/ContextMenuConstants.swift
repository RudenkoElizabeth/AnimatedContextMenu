//
//  ContextMenuConstants.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 28.01.2022.
//

import Foundation

class ContextMenuConstants {
    enum State {
        case closed
        case open
        
        var opposite: State {
            switch self {
            case .open: return .closed
            case .closed: return .open
            }
        }
    }
    static let cell = "ContextMenuCell"
    static let menuItems: [MenuItem] = [
        MenuItem(title: "Lorem ipsum dolor sit amet", icon: "gamecontroller"),
        MenuItem(title: "Integer varius lorem", icon: "network"),
        MenuItem(title: "Aliquam semper ipsum", icon: "network"),
        MenuItem(title: "Etiam egestas libero", icon: "person.circle"),
        MenuItem(title: "Cras facilisis ipsum", icon: "globe.americas")
    ]
}
