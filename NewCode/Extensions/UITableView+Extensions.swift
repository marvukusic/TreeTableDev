//
//  UITableView+Extensions.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 03.03.2021..
//

import UIKit
import Differ

extension UITableView {
    func reloadChanges<T: Collection>(from old: T, to new: T) where T.Element: Equatable {
        animateRowChanges(oldData: old, newData: new)
    }
}
