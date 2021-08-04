//
//  MovieDetailNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import UIKit

protocol MovieDetailNavigatorType {
    func toDetailScreen(movie: Movie)
}

struct MovieDetailNavigator: MovieDetailNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(movie: Movie) {
        let vc = MovieDetailViewController.instance(navigationController: navigationController, movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}

