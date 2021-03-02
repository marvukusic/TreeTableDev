//
//  TableViewable.swift
//  HeatSeekr
//
//  Created by Marko Vukusic on 30/06/2020.
//  Copyright © 2020 CodeSplitters. All rights reserved.
//

import UIKit

protocol TableViewable {
    var tableView: UITableView! { get set }
}

extension TableViewable where Self: UIViewController {
    func buildCell<T: UITableViewCell>(of type: T.Type, at indexPath: IndexPath) -> T where T: Identifiable {
        return tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
