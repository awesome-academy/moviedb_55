//
//  MovieDetailNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import UIKit

protocol MovieDetailNavigatorType {
    func toDetailScreen(id: Int)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(id: Int) {
        let vc = MovieDetailViewController.instance(navigationController: navigationController, movieId: id)
        navigationController.pushViewController(vc, animated: true)
    }
}

