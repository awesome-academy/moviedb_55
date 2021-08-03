//
//  TabBarController.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import UIKit
import Then

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    private func createTabbarItem(title: String, nameIcon: String) -> UITabBarItem {
        return UITabBarItem(title: title,
                            image: UIImage(systemName: nameIcon),
                            selectedImage: UIImage(systemName: "\(nameIcon).fill"))
    }
    
    private func configureViewControllers() {
        // home
        let homeNavigation = UINavigationController()
        let homeVC = HomeViewController.instance(navigationController: homeNavigation)
        homeNavigation.viewControllers.append(homeVC)
        homeVC.tabBarItem = createTabbarItem(title: "Home", nameIcon: "house")
        
        // search
        let searchNavigation = UINavigationController()
        let searchVC = SearchViewController.instance(navigationController: searchNavigation)
        searchNavigation.viewControllers.append(searchVC)
        searchVC.tabBarItem = createTabbarItem(title: "Search", nameIcon: "magnifyingglass.circle")
        
        //favorites
        let favoriteNavigation = UINavigationController()
        let favoritesVC = FavoritesViewController.instance(navigationController: favoriteNavigation)
        favoriteNavigation.viewControllers.append(favoritesVC)
        favoritesVC.tabBarItem = createTabbarItem(title: "Favorites", nameIcon: "heart")
    
        viewControllers = [homeNavigation, searchNavigation, favoriteNavigation]
    }
}
