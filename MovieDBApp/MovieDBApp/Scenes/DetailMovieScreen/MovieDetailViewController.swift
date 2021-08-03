//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

class MovieDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
    }
    
    func bindViewModel(viewModel: MovieDetailViewModel) {
        let input = MovieDetailViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        output.movieDetail
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension MovieDetailViewController {
    static func instance(navigationController: UINavigationController, movieId: Int) -> MovieDetailViewController {
        let useCase = MovieDetailUseCase(movieRepository: MoviesRepository())
        let viewModel = MovieDetailViewModel(useCase: useCase, movieId: movieId)
        let vc = MovieDetailViewController()
        vc.bindViewModel(viewModel: viewModel)
        return vc
    }
}
