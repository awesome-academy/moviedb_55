//
//  MovieDetailViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

final class MovieDetailViewController: UIViewController {
    typealias DataSource = RxTableViewSectionedReloadDataSource<MovieDetailSectionModel>
    
    @IBOutlet private weak var detailTableView: UITableView!
    
    private var dataSource: DataSource!
    private var viewModel: MovieDetailViewModel!
    private let selectMovieTrigger = PublishSubject<Movie>()
    private let selectFavoriteMovieTrigger = PublishSubject<Bool>()
    
    private let heightForTrailer: CGFloat = 225
    private let heightForInfo: CGFloat = 160
    private let heightForCast: CGFloat = 190
    private let heightForRecommended: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Movie Details"
        
        detailTableView.do {
            $0.register(cellType: TrailerTableViewCell.self)
            $0.register(cellType: InfomationTableViewCell.self)
            $0.register(cellType: CastAndCrewTableViewCell.self)
            $0.register(cellType: RecomendedTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.delegate = self
        }
        
        dataSource = DataSource(configureCell: configureCell)
    }
    
    func bindViewModel() {
        let input = MovieDetailViewModel.Input(
            loadTrigger: Driver.just(()),
            selectMovieTrigger: selectMovieTrigger.asDriver(onErrorJustReturn: Movie()),
            likeMovieTrigger: selectFavoriteMovieTrigger.asDriver(onErrorJustReturn: false)
        )
        let output = viewModel.transform(input: input)
        
        
        output.movieDetail
            .drive(detailTableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        output.selectedMovieId
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.handleStatus.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
    }
    
    func messageAddFavoriteMovie(status: Bool) {
        let alert = UIAlertController(title: "Notification",
                                      message: status ?
                                        DatabaseAlert.addSuccessfully.message :
                                        DatabaseAlert.deleteSuccessfully.message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MovieDetailViewController {
    static func instance(navigationController: UINavigationController, movie: Movie) -> MovieDetailViewController {
        let useCase = MovieDetailUseCase(movieRepository: MoviesRepository(), databaseRepository: DatabaseRepository() )
        let navigator = MovieDetailNavigator(navigationController: navigationController)
        let viewModel = MovieDetailViewModel(useCase: useCase, navigator: navigator, movie: movie)
        let vc = MovieDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
}

extension MovieDetailViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { [unowned self] (dataSource, tableView, indexPath, _) in
            switch dataSource[indexPath] {
            case .trailer(let linkId):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TrailerTableViewCell.self)
                cell.configure(linkId: linkId)
                return cell
            case .info(let movieDetail, let status):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: InfomationTableViewCell.self)
                cell.onLikeMovieTapped = {
                    selectFavoriteMovieTrigger.onNext($0)
                    messageAddFavoriteMovie(status: !status)
                }
                cell.configure(movieDetail: movieDetail, status: status)
                return cell
            case .casts(let credits):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CastAndCrewTableViewCell.self)
                cell.configure(credits: credits)
                return cell
            case .movieRecommended(let recomended):
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecomendedTableViewCell.self)
                cell.configure(recomended: recomended)
                cell.onItemMovieTapped = {
                    selectMovieTrigger.onNext($0)
                }
                return cell
            }
        }
    }
}

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .trailer:
            return heightForTrailer
        case .info:
            return heightForInfo
        case .casts:
            return heightForCast
        case .movieRecommended:
            return heightForRecommended
        }
    }
}

