//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable

class MovieDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieDetailViewController {
    static func instance() -> MovieDetailViewController {
        let detailVC = MovieDetailViewController()
        return detailVC
    }
}
