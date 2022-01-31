//
//  ContextMenuCell.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 31.01.2022.
//

import UIKit

class ContextMenuCell: UITableViewCell {
     
    @IBOutlet private weak var titleLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.textColor = isSelected ? .cyan : .label
    }

    func set(title: String?) {
        titleLabel.text = title
    }
}
