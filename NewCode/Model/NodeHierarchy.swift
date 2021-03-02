//
//  NodeHierarchy.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import Foundation

class NodeHierarchy: Codable {
    var items = [Node]()
}

class Node: Codable, SelfDescribing {
    var id              : Int?
    var nodeType        = NodeType.unknown
    var isFacility      = false
    var type            = NodeType.unknown
    var nodeId          : Int?
    var nodeName        : String?
    var level           : Int?
    var children        = [Node]()
    var isAccessible    = false
    var isCompany       = false
    var treePath        = ""
    var name            = ""
    var parentId        : Int?
    var parentName      : String?
    
    var isVisible = true
    var isExpanded = true
    
    private enum CodingKeys: String, CodingKey {
        case id
        case nodeType
        case isFacility
        case type
        case nodeId
        case nodeName
        case level
        case children
        case isAccessible
        case isCompany
        case treePath
        case name
        case parentId
        case parentName
    }
    
    func showNode(_ visible: Bool) {
        isVisible = visible
    }
}

enum NodeType: String, Codable {
    case organizationStructure = "ORGANIZATION_STRUCTURE"
    case custom = "CUSTOM"
    case unknown = ""
}
