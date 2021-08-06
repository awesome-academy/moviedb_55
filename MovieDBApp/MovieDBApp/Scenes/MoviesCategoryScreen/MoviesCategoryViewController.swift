//
//  MoviesCategoryViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 06/08/2021.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import NSObject_Rx
import Reusable

final class MoviesCategoryViewController: UIViewController {
    
    @IBOutlet private weak var categoryTableView: UITableView!
    
    var viewModel: MoviesCategoryViewModel!
    private var numberOfPage = 0
    private let loadMoreTrigger = PublishSubject<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        categoryTableView.do {
            $0.register(cellType: SearchTableViewCell.self)
            $0.tableFooterView = UIView(frame: .zero)
            $0.tableHeaderView = UIView(frame: .zero)
            $0.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            $0.delegate = self
        }
    }
    
    private func bindViewModel() {
        let input = MoviesCategoryViewModel.Input(
            loadMoreTrigger: loadMoreTrigger.asDriver(onErrorDriveWith: .empty()),
            selectMovieTrigger: categoryTableView.rx.itemSelected.asDriver(onErrorDriveWith: .empty())
        )
        let output = viewModel.transform(input: input)
        
        output.movies
            .do { [unowned self] _ in
                numberOfPage += 1
            }
            .drive(categoryTableView.rx.items) { tableView, index, movie in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SearchTableViewCell.self)
                cell.configure(movie: movie)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.voidDrivers.forEach {
            $0.drive()
                .disposed(by: rx.disposeBag)
        }
    }
}

extension MoviesCategoryViewController {
    static func instance(navigationController: UINavigationController, category: MovieCategory) -> MoviesCategoryViewController {
        let useCase = MoviesCategoryUseCase(moviesRepository: MoviesRepository())
        let navigator = MoviesCategoryNavigator(navigationController: navigationController)
        let viewModel = MoviesCategoryViewModel(useCase: useCase, navigator: navigator, category: category)
        let vc = MoviesCategoryViewController()
        vc.navigationItem.title = category.getTitle
        vc.viewModel = viewModel
        return vc
    }
}

extension MoviesCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let lastFrameTableView = (categoryTableView.contentSize.height - scrollView.frame.size.height + 50)
        
        if (position > lastFrameTableView) {
            loadMoreTrigger.onNext(numberOfPage)
        }
    }
}
