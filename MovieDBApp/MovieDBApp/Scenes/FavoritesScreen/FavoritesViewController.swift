//
//  FavoritesViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift
import Then
import NSObject_Rx

final class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    private let loadTrigger = PublishSubject<Void>()
    private let movieDeleteTrigger = PublishSubject<IndexPath>()
    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTrigger.onNext(())
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        favoritesCollectionView.do {
            $0.register(cellType: FavoritesCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.delegate = self
        }
        setupLayout()
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize( width: (view.bounds.width / 3) - 28, height: 190)
            $0.minimumLineSpacing = 16
        }
        favoritesCollectionView.collectionViewLayout = layout
    }
    
    private func bindViewModel() {
        let input = FavoritesViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ()),
            selectMovieTrigger: favoritesCollectionView.rx.itemSelected.asDriver(onErrorDriveWith: .empty()),
            movieDeleteTrigger: movieDeleteTrigger.asDriver(onErrorDriveWith: .empty())
        )

        let output = viewModel.transform(input: input)
        
        output.moviesFavorite
            .drive(favoritesCollectionView.rx.items) { (collectionView, index, movie) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FavoritesCollectionViewCell.self)
                cell.configure(path: movie.poster)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.movieSelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.movieDeleted
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension FavoritesViewController {
    static func instance(navigationController: UINavigationController) -> FavoritesViewController {
        let useCase = FavoriteUseCase(databaseRepository: DatabaseRepository())
        let navigator = FavoritesNavigator(navigationController: navigationController)
        let viewModel = FavoritesViewModel(useCase: useCase, navigator: navigator)
        let vc = FavoritesViewController()
        vc.viewModel = viewModel
        return vc
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [unowned self] _ in
                movieDeleteTrigger.onNext(indexPath)
                loadTrigger.onNext(())
            }
            return UIMenu(title: "", children: [delete])
        }
    }
}
