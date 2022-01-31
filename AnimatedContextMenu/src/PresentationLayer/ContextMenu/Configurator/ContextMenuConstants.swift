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
    static let titles = [ "menu 1", "menu 2", "menu3" ]
}
