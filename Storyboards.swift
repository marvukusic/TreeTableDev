//
//  AppStoryboards.swift
//  Myo
//
//  Created by Marko Vukušić on 22.02.2021..
//  Copyright © 2021 Myo GmbH. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboards : String {
    case TableTreeView
}

extension AppStoryboards {
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let viewController = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard")
        }
        return viewController
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}
