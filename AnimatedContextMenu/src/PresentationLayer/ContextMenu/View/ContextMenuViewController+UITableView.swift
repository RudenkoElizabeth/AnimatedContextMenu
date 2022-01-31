//
//  ContextMenuViewController+UITableView.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 31.01.2022.
//

import UIKit

extension ContextMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContextMenuConstants.titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ContextMenuConstants.cell
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! ContextMenuCell
        cell.set(title: ContextMenuConstants.titles[indexPath.row])
        return cell
    }
}

extension ContextMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt \(indexPath.row)")
    }
}
