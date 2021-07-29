//
//  SearchViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import UIKit

class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension SearchViewController {
    static func instance(navigationController: UINavigationController) -> SearchViewController {
        let vc = SearchViewController()
        return vc
    }
}
