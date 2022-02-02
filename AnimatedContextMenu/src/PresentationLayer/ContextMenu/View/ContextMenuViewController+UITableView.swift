//
//  ContextMenuViewController+UITableView.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 31.01.2022.
//

import UIKit

extension ContextMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContextMenuConstants.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ContextMenuConstants.cell
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ContextMenuCell
        let item = ContextMenuConstants.menuItems[indexPath.row]
        cell.set(title: item.title)
        cell.setIcon(name: item.icon)
        return cell
    }
}

extension ContextMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath.row)")
    }
}
