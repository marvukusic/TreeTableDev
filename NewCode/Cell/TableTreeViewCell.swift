//
//  TableTreeViewCell.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

class TableTreeViewCell: UITableViewCell, Identifiable {
    
    var nodeSelectedAction: ((Node) -> Void)?

    @IBOutlet weak var indentConstraint:    NSLayoutConstraint!
    @IBOutlet weak var dropdownImageView:   UIImageView!
    @IBOutlet weak var nameLabel:           UILabel!
    @IBOutlet weak var selectButton:        UIButton!
    
    private var node: Node?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(node: Node) -> Self {
        self.node = node
        
        dropdownImageView.image = node.dropdownImage
        nameLabel.text = node.getName()
        selectButton.setImage(node.checkboxImage, for: .normal)
        
        indentConstraint.constant = CGFloat(node.nodeLevel) * 20
        return self
    }
    
    @IBAction func selectAction(_ sender: UIButton) {
        guard let node = node else { return }
        nodeSelectedAction?(node)
    }
}
