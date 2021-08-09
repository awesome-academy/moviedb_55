//
//  SearchViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx
import Reusable

final class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var searchAlert: UILabel!
    
    var viewModel: SearchViewModel!
    private var number = 1
    private let loadMoreTrigger = PublishSubject<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchTableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.delegate = self
        }
    }
    
    private func bindViewModel() {
        let input = SearchViewModel.Input(
            searchBarTrigger: searchBar.rx.text.orEmpty.asDriver(),
            loadMoreTrigger: loadMoreTrigger.asDriver(onErrorDriveWith: .empty()),
            selectMovieTrigger: searchTableView.rx.itemSelected.asDriver(onErrorDriveWith: .empty())
        )
        
        let output = viewModel.transform(input: input)
        
        output.movies
            .do { [unowned self] in
                if $0.isEmpty {
                    number = 1
                }
                searchTableView.tableFooterView = nil
            }
            .drive(searchTableView.rx.items) { tableView, index, movie in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
                cell.configure(movie: movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.movieSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.moviesDriver.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
        
        output.notFoundMovie
            .do { [unowned self] in
                if !$0 {
                    number = 1
                }
            }
            .drive(searchAlert.rx.isHidden)
            .disposed(by: rx.disposeBag)
    }
}

extension SearchViewController {
    static func instance(navigationController: UINavigationController) -> SearchViewController {
        let useCase = SearchUseCase(moviesRepository: MoviesRepository())
        let navigator = SearchNavigator(navigationController: navigationController)
        let viewModel = SearchViewModel(useCase: useCase, navigator: navigator)
        let vc = SearchViewController()
        vc.viewModel = viewModel
        return vc
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let lastFrameTableView = (searchTableView.contentSize.height - scrollView.frame.size.height + 50)
        
        if (position > lastFrameTableView) {
            number += 1
            searchTableView.tableFooterView = createSpinner(width: view.frame.size.width)
            loadMoreTrigger.onNext(number)
        }
    }
}
