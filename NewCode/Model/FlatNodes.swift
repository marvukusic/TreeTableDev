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
    
    func findSearchedNodes(searchText: String?) {
        guard let searchText = searchText, searchText != "" else {
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
        for child in findChildren(of: node) {
            !child.children.isEmpty ?
                setChildrenAsSearched(of: child) :
                setAsSearched(child)
        }
    }
    
    private func setParentAsSearched(of node: Node) {
        if let parent = findParent(of: node) {
            setAsSearched(parent)
            setParentAsSearched(of: parent)
        }
    }
    
    private func setNodesSearchedFlag(as searched: Bool) {
        nodes.forEach { $0.setIsSearched(searched) }
    }
    
    private func setAsSearched(_ node: Node) {
        node.setIsSearched(true)
    }
    
    
    //////////
    
    func setSelection(of node: Node, selected: NodeSelection) {
        selectNode(node, selectionType: selected)
        selectChildren(of: node, selected: selected)
        selectParent(of: node, selected: selected)
        
        let topNode = nodes.first(where: {$0.isTopLevelNode})
        checkPartialSelection(of: topNode)
    }
    
    private func selectChildren(of node: Node, selected: NodeSelection) {
        selectNode(node, selectionType: selected)
        for child in findChildren(of: node) {
            !child.children.isEmpty ?
                selectChildren(of: child, selected: selected) :
                selectNode(child, selectionType: selected)
        }
    }
    
    private func selectNode(_ node: Node, selectionType: NodeSelection) {
        node.setSelection(type: selectionType)
    }
    
    private func selectParent(of node: Node, selected: NodeSelection) {
        guard selected == .full else { return }
        if let parent = findParent(of: node) {
            selectNode(parent, selectionType: selected)
            selectParent(of: parent, selected: selected)
        }
    }
    
    private func checkPartialSelection(of node: Node?) {
        guard let node = node else { return }
        
        if node.selectionType == .full {
            let hasUnSelectedChildren = node.children.filter({$0.selectionType == .none}).count > 0
            selectNode(node, selectionType: hasUnSelectedChildren ? .partial : .full)
        } else {
            let hasSelectedChildren = node.children.filter({$0.selectionType != .none}).count > 0
            selectNode(node, selectionType: hasSelectedChildren ? .partial : .none)
        }
        
        for child in findChildren(of: node) {
            if !child.children.isEmpty {
                checkPartialSelection(of: child)
            }
        }
    }
    
    private func findChildren(of node: Node) -> [Node] {
        nodes.filter({$0.parentId == node.id})
    }
    
    private func findParent(of node: Node) -> Node? {
        nodes.filter({$0.id == node.parentId}).first
    }
}
