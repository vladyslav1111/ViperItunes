//
//  MainTabBarController.swift
//  iTunesMovieSearch
//
//  Created by Vlad Tkachuk on 16.08.2021.
//  Copyright © 2021 Vlad Tkachuk. All rights reserved.
//

import UIKit
import Common
import Search

class MainTabBarController: UITabBarController {
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let config = Config()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0, blue: 0.3764705882, alpha: 1)
        searchVC.configure(with: config)
        let navigationSearchVC = self.generateViewController(rootViewController: searchVC, image: #imageLiteral(resourceName: "search"), title: "Search")
        viewControllers = [
            navigationSearchVC,
            UIViewController()
        ]
    }
    
    private func generateViewController(rootViewController controller: UIViewController,
                                        image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: controller)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        controller.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
