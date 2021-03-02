//
//  UIViewController+Extensions.swift
//  TreeTableDev
//
//  Created by Marko Vukušić on 01.03.2021..
//

import UIKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)

        if let frame = frame {
            child.view.frame = frame
        }

        view.addSubview(child.view)
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
