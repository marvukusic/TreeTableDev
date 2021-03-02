//
//  Codable+Extensions.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import Foundation

extension Encodable {
    var prettyPrinted: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try! encoder.encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}


