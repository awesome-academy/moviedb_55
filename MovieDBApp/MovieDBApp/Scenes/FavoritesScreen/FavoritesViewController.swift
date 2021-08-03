//
//  FavoritesViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension FavoritesViewController {
    static func instance(navigationController: UINavigationController) -> FavoritesViewController {
        let vc = FavoritesViewController()
        return vc
    }
}
