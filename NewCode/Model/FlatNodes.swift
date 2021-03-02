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
        node.setExpanded(visible)
        
        for child in findChildren(of: node) {
            child.showNode(visible)
            if !child.children.isEmpty {
                setVisibility(of: child, visible: visible)
            }
        }
    }
    
    func setSelection(of node: Node, selected: Bool) {
        selectNode(node, selectionType: selected ? .full : .none)
        selectChildren(of: node, selected: selected)
        selectParent(of: node, selected: selected)
    }
    
    private func selectChildren(of node: Node, selected: Bool) {
        selectNode(node, selectionType: selected ? .full : .none)
        for child in findChildren(of: node) {
            !child.children.isEmpty ?
                selectChildren(of: child, selected: selected) :
                selectNode(child, selectionType: selected ? .full : .none)
        }
    }
    
    private func selectNode(_ node: Node, selectionType: NodeSelection) {
        node.setSelection(type: selectionType)
    }
    
    private func selectParent(of node: Node, selected: Bool) {
        if let parent = findParent(of: node) {
            selectNode(parent, selectionType: selected ? .partial : .none)
            selectParent(of: parent, selected: selected)
        }
    }
    
    private func findChildren(of node: Node) -> [Node] {
        nodes.filter({$0.parentId == node.id})
    }
    
    private func findParent(of node: Node) -> Node? {
        nodes.filter({$0.id == node.parentId}).first
    }
}
