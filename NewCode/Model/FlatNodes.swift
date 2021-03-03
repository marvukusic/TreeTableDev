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
        
        findChildren(of: node).forEach { child in
            child.showNode(visible)
            if child.hasChildren {
                setVisibility(of: child, visible: visible)
            }
        }
    }
    
    func findSearchedNodes(searchText: String?) {
        guard let searchText = searchText,
              searchText != "" else {
            setNodesSearchedFlag(as: true)
            return
        }
        
        setNodesSearchedFlag(as: false)
        let searchedNodes = nodes.filter { $0.name.contains(searchText) }
        searchedNodes.forEach { searchedNode in
            setChildrenAsSearched(of: searchedNode)
            setParentAsSearched(of: searchedNode)
        }
    }
    
    private func setChildrenAsSearched(of node: Node) {
        setAsSearched(node)
        findChildren(of: node).forEach { child in
            child.hasChildren ?
                setChildrenAsSearched(of: child) :
                setAsSearched(child)
        }
    }
    
    private func setParentAsSearched(of node: Node) {
        guard let parent = findParent(of: node) else { return }
        setAsSearched(parent)
        setParentAsSearched(of: parent)
    }
    
    private func setNodesSearchedFlag(as searched: Bool) {
        nodes.forEach { $0.setIsSearched(searched) }
    }
    
    private func setAsSearched(_ node: Node) {
        node.setIsSearched(true)
    }

    func setSelection(of node: Node, selected: NodeSelection) {
        selectNode(node, selectionType: selected)
        selectChildren(of: node, selected: selected)
        
        if let parent = findParent(of: node) {
            checkChildSelection(of: parent, selected: selected)
        }
    }
    
    private func selectChildren(of node: Node, selected: NodeSelection) {
        selectNode(node, selectionType: selected)
        findChildren(of: node).forEach { child in
            child.hasChildren ?
                selectChildren(of: child, selected: selected) :
                selectNode(child, selectionType: selected)
        }
    }
    
    private func selectNode(_ node: Node, selectionType: NodeSelection) {
        node.setSelection(type: selectionType)
    }
    
    private func checkChildSelection(of node: Node, selected: NodeSelection) {
        selectNode(node, selectionType: node.childrenSelectionType)
        if let parent = findParent(of: node) {
            checkChildSelection(of: parent, selected: selected)
        }
    }
    
    private func findChildren(of node: Node) -> [Node] {
        nodes.filter({$0.parentId == node.id})
    }
    
    private func findParent(of node: Node) -> Node? {
        nodes.filter({$0.id == node.parentId}).first
    }
}
