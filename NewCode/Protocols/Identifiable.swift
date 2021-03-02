//
//  Identifiable.swift
//  HeatSeekr
//
//  Created by Marko Vukusic on 30/06/2020.
//  Copyright © 2020 CodeSplitters. All rights reserved.
//

import Foundation

protocol Identifiable {
    
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
