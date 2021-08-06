//
//  HomeNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 02/08/2021.
//

import UIKit

protocol HomeNavigatorType {
    func toDetailScreen(movie: Movie)
    func toMoviesCategoryScreen(category: MovieCategory)
}

struct HomeNavigator: HomeNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(movie: Movie) {
        let vc = MovieDetailViewController.instance(navigationController: navigationController, movie: movie)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toMoviesCategoryScreen(category: MovieCategory) {
        let vc = MoviesCategoryViewController.instance(navigationController: navigationController, category: category)
        navigationController.pushViewController(vc, animated: true)
    }
}
