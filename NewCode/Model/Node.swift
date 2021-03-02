//
//  Node.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

enum NodeSelection {
    case none, partial, full
}

class Node: Codable, SelfDescribing {
    static let topNodeLevel = 2
    
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
    
    private(set) var isVisible       = true
    private(set) var isExpanded      = true
    private(set) var isSelected      = false
    private(set) var selectionType   = NodeSelection.none

    var hasChildren: Bool {
        !children.isEmpty
    }
    
    var nodeLevel: Int {
        guard let level = level, level > 1 else { return 0 }
        return level - 1
    }
    
    var isTopLevelNode: Bool {
        level == Node.topNodeLevel
    }
    
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
    
    func setExpanded(_ expanded: Bool) {
        isExpanded = expanded
    }
    
    func setSelection(type: NodeSelection) {
        isSelected = selectionType == .full
        selectionType = type
    }
    
    func getName() -> String {
        //TODO: Localize
        isTopLevelNode ? "All locations" : nodeName ?? ""
    }
    
    var dropdownImage: UIImage? {
        //TODO: Tidy up a bit
        guard !isTopLevelNode else { return UIImage(named: "icon_building") }
        guard hasChildren else { return UIImage(named: "dropdown_none") }
        return isExpanded ? UIImage(named: "dropdown_expanded") : UIImage(named: "dropdown_collapsed")
    }
    
    var checkboxImage: UIImage? {
        //TODO: Tidy up a bit
        switch selectionType {
        case .full:
            return UIImage(named: "checkbox_selected")
        case .partial:
            return isTopLevelNode ? UIImage(named: "checkbox_dash") : UIImage(named: "checkbox_partially_selected")
        case .none:
            return UIImage(named: "checkbox_unselected")
        }
    }
}

enum NodeType: String, Codable {
    case organizationStructure = "ORGANIZATION_STRUCTURE"
    case custom = "CUSTOM"
    case unknown = ""
}
