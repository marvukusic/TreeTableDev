//
//  FlatNodes.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import Foundation

class FlatNodes {
    var nodes = [Node]()
    
    func setVisibility(of node: Node, visible: Bool) {
        node.isExpanded = visible
        let children = nodes.filter({$0.parentId == node.id})
        for child in children {
            child.showNode(visible)
            if !child.children.isEmpty {
                setVisibility(of: child, visible: visible)
            }
        }
    }
}
