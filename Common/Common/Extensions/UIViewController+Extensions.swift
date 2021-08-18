//
//  UIViewController+Extensions.swift
//  Common
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit

public extension UIViewController {
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle(for: T.self))
        if let vc = storyboard.instantiateInitialViewController() as? T {
            return vc
        }
        fatalError("Error: No inital view controller in \(name) storyboard")
    }
}
