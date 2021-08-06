//
//  MoviesCategoryNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 06/08/2021.
//

import UIKit

protocol MoviesCategoryNavigatorType {
    func toDetailScreen(movie: Movie)
}

struct MoviesCategoryNavigator: MoviesCategoryNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(movie: Movie) {
        let vc = MovieDetailViewController.instance(navigationController: navigationController, movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}
