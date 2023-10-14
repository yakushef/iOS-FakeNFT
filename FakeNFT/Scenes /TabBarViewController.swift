//
//  TabBarViewController.swift
//  FakeNFT
//
//  Created by Andy Kruch on 10.10.23.
//

import UIKit

class TabBarViewController: UITabBarController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .blue
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let profileViewController = ProfileViewController()
        let catalogViewController = CatalogViewController()
        let cartViewController = CartViewController()
        let statisticViewController = StatisticViewController()
        
        profileViewController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(named: "Profile"),
            selectedImage: nil
        )
        catalogViewController.tabBarItem = UITabBarItem(
            title: "Каталог",
            image: UIImage(named: "Catalog"),
            selectedImage: nil
        )
        cartViewController.tabBarItem = UITabBarItem(
            title: "Корзина",
            image: UIImage(named: "Cart"),
            selectedImage: nil
        )
        statisticViewController.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "Statistic"),
            selectedImage: nil
        )
        
        
        let controllers = [profileViewController, catalogViewController, cartViewController, statisticViewController]
        
        viewControllers = controllers
    }
}
