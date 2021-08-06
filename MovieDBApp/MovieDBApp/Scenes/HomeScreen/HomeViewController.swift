//
//  HomeViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 30/07/2021.
//

import UIKit
import Then
import RxCocoa
import RxSwift
import Reusable
import NSObject_Rx
import RxDataSources

final class HomeViewController: UIViewController {
    typealias DataSource = RxTableViewSectionedReloadDataSource<MoviesSection>
    var viewModel: HomeViewModel!
    private var dataSource: DataSource!
    private let selectMovieTrigger = PublishSubject<Movie>()
    private let selectCategoryTrigger = PublishSubject<MovieCategory>()
    
    @IBOutlet private weak var movieTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        movieTableView.do {
            $0.register(cellType: HomeTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.delegate = self
        }
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(
            loadTrigger: Driver.just(()),
            selectMovieTrigger: selectMovieTrigger.asDriver(onErrorJustReturn: Movie()),
            selectCategoryTrigger: selectCategoryTrigger.asDriver(onErrorJustReturn: .none)
        )
        
        let output = viewModel.transform(input: input)
        dataSource = DataSource(configureCell: configureCell)
        
        output.movies
            .drive(movieTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
    }
}

extension HomeViewController {
    static func instance(navigationController: UINavigationController) -> HomeViewController {
        let vc = HomeViewController()
        let useCase = HomeUseCase(moviesRepository: MoviesRepository())
        let navigator = HomeNavigator(navigationController: navigationController)
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        vc.viewModel = viewModel
        return vc
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension HomeViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { [unowned self] (dataSource, tableView, indexPath, _) in
            let cell = tableView.dequeueReusableCell(for: indexPath,
                                                     cellType: HomeTableViewCell.self)
            var model: MovieSession
            
            switch dataSource[indexPath] {
            case .nowPlaying(let movieSesction):
                model = movieSesction
            case .upcoming(let movieSesction):
                model = movieSesction
            case .popular(let movieSesction):
                model = movieSesction
            case .topRated(let movieSesction):
                model = movieSesction
            }
            
            cell.selectionStyle = .none
            cell.onItemMovieTapped = {
                selectMovieTrigger.onNext($0)
            }
            cell.onMoviesCategoryTapped = {
                selectCategoryTrigger.onNext($0)
            }
            cell.configure(model: model)
            return cell
        }
    }
}
