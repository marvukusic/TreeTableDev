//
//  SelfDescribing.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 02.03.2021..
//

import Foundation

public protocol SelfDescribing : CustomStringConvertible { }

extension SelfDescribing {
  public var description: String {
    let mirror = Mirror(reflecting: self)
    
    var str = "\(mirror.subjectType)("
    var first = true
    for (label, value) in mirror.children {
      if let label = label {
        if first {
          first = false
        } else {
          str += ", "
        }
        str += label
        str += ": "
        str += "\(value)\n"
      }
    }
    str += ")"
    
    return str
  }
}
