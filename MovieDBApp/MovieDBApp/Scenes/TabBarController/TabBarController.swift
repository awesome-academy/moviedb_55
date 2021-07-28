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
    
    private func createViewController(textIcon: String,
                              nameIcon: String,
                              vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        vc.navigationItem.title = textIcon == "Home" ? "Movies" : textIcon
        nav.navigationBar.prefersLargeTitles = true
        
        let title = UILabel().then {
            $0.font = .systemFont(ofSize: 16)
            $0.text = textIcon
        }
        
        vc.tabBarItem = UITabBarItem(title: title.text,
                                         image: UIImage(systemName: nameIcon),
                                         selectedImage: UIImage(systemName: "\(nameIcon).fill"))
        return nav
    }
    
    private func configureViewControllers() {
        let homeVC = HomeViewController()
        let navHomeVC = createViewController(textIcon: "Home",
                                             nameIcon: "house",
                                             vc: homeVC)
        
        let searchVC = SearchViewController()
        let navSearchVC = createViewController(textIcon: "Search",
                                               nameIcon: "magnifyingglass.circle",
                                               vc: searchVC)
        
        let favoritesVC = FavoritesViewController()
        let navFavoritesVC = createViewController(textIcon: "Favorites",
                                                  nameIcon: "heart",
                                                  vc: favoritesVC)
        
        viewControllers = [navHomeVC, navSearchVC, navFavoritesVC]
    }
}
