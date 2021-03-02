//
//  ViewController.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nodeTreeContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNodeTreeView()
    }
    
    private func loadNodeTreeView() {
        let vc = TableTreeViewController.instantiate(from: .TableTreeView)
        add(vc, frame: nodeTreeContainer.frame)
    }
}

