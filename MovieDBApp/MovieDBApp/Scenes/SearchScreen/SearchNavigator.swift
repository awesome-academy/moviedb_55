//
//  SearchNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit

protocol SearchNavigatorType {
    func toDetailScreen(movie: Movie)
}

struct SearchNavigator: SearchNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(movie: Movie) {
        let vc = MovieDetailViewController.instance(navigationController: navigationController, movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
}

