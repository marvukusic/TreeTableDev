//
//  UIViewController+Extensions.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, to view: UIView) {
        addChild(child)

        view.addSubview(child.view)
        child.view.pinEdges(to: view)
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(from storyboard: AppStoryboards) -> Self {
        return storyboard.viewController(viewControllerClass: self)
    }
    
    static func getNavigation(from storyboard: AppStoryboards) -> UINavigationController {
        guard let nav = storyboard.initialViewController() as? UINavigationController else {
            return UINavigationController()
        }
        return nav
    }
}
