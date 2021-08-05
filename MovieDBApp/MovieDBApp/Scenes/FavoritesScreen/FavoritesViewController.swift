//
//  FavoritesViewController.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    @IBOutlet private weak var favoritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        favoritesCollectionView.do {
            $0.register(cellType: FavoritesCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.delegate = self
            $0.dataSource = self
        }
        setupLayout()
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize( width: (view.bounds.width / 3) - 28, height: 190)
            $0.minimumLineSpacing = 0
        }
        favoritesCollectionView.collectionViewLayout = layout
    }
}

extension FavoritesViewController {
    static func instance(navigationController: UINavigationController) -> FavoritesViewController {
        let vc = FavoritesViewController()
        return vc
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FavoritesCollectionViewCell.self)
        return cell
    }
}
