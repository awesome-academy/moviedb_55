//
//  HomeNavigator.swift
//  MovieDBApp
//
//  Created by Phong Le on 02/08/2021.
//

import UIKit

protocol HomeNavigatorType {
    func toDetailScreen(id: Int)
}

struct HomeNavigator: HomeNavigatorType {
    let navigationController: UINavigationController
    
    func toDetailScreen(id: Int) {
        let detailVC = MovieDetailViewController.instance()
        navigationController.presentVC(vc: detailVC, duration: 0.32, type: .fromRight)
    }
}
