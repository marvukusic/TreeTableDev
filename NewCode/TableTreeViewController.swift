//
//  TableTreeViewController.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

class TableTreeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var flatNodes = FlatNodes()
    
    var nodes: [Node] {
        flatNodes.nodes.filter { $0.isVisible }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
    
    private func getData() {
        guard let path = Bundle.main.url(forResource: "data", withExtension: "json"),
              let nodeHierarchy: NodeHierarchy = path.decode() else { return }
        flatNodes.nodes = recursiveFlatmap(of: nodeHierarchy.items)
//        tableView.reloadData()
    }
    
    func recursiveFlatmap(of nodes: [Node]) -> [Node] {
        var results = [Node]()
        results.reserveCapacity(nodes.count)
        for node in nodes {
            results.append(node)
            if !node.children.isEmpty {
                results += recursiveFlatmap(of: node.children)
            }
            
        }
        return results
    }
}

extension TableTreeViewController: UITableViewDataSource, TableViewable {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return buildCell(of: TableTreeViewCell.self, at: indexPath).setup(node: nodes[indexPath.row])
    }
}

extension TableTreeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node = nodes[indexPath.row]
        flatNodes.setVisibility(of: node, visible: !node.isExpanded)
        tableView.reloadData()
    }
}
