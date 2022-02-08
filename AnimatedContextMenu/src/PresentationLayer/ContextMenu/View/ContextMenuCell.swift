//
//  ContextMenuCell.swift
//  AnimatedContextMenu
//
//  Created by Elizaveta Rudenko on 31.01.2022.
//

import UIKit

class ContextMenuCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        icon.image = nil
        titleLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let color: UIColor = isSelected ? .label : .systemBackground
        titleLabel.textColor = color
        icon.tintColor = color
    }
    
    func set(title: String?) {
        titleLabel.text = title
    }
    
    func setIcon(name: String) {
        icon.image = UIImage(systemName: name)
    }
}
