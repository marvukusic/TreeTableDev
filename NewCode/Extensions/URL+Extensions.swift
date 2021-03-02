//
//  URL+Extensions.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import Foundation

extension URL {
    func decode<T: Decodable>() -> T? {
        do {
            let data = try Data(contentsOf: self)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
