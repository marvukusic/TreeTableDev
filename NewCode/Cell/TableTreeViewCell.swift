//
//  TableTreeViewCell.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

class TableTreeViewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var indentConstraint: NSLayoutConstraint!
    @IBOutlet weak var dropdownImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(node: Node) -> Self {
        dropdownImageView.image = node.dropdownImage
        nameLabel.text = node.name
        
        let level = (node.level ?? 2) - 1
        indentConstraint.constant = CGFloat(level) * 20
        return self
    }
}
