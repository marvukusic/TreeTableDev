//
//  TableTreeViewCell.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

class TableTreeViewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelLeadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(node: Node) -> Self {
        nameLabel.text = node.name
        nameLabelLeadingConstraint.constant = CGFloat((node.level ?? 0) * 50)
        return self
    }
}
