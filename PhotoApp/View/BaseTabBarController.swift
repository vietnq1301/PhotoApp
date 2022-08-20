//
//  BaseTabBarController.swift
//  AppstoreApiJson
//
//  Created by Nguyễn Thành Trung on 1/31/21.
//  Copyright © 2021 Nguyễn Quốc Việt. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: HomeVC(), title: "Home", imageName: "house.fll")
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.backgroundColor = .systemGroupedBackground
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: imageName)
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .systemGroupedBackground
            navController.navigationBar.standardAppearance = navBarAppearance
            navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        return navController
    }
}
