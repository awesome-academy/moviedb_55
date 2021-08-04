//
//  RecomendedTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable

final class RecomendedTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var recomendedCollectionView: UICollectionView!
    private var recomendedMovies = [SimilarMovie]()
    var onItemMovieTapped: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(recomended: SimilarMovies) {
        recomendedMovies = recomended.results
    }
    
    private func setupView() {
        selectionStyle = .none
        recomendedCollectionView.do {
            $0.register(cellType: RecomendedCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.delegate = self
            $0.dataSource = self
            setupLayout()
        }
    }
    
    private func setupLayout() {
        let layout = UICollectionViewFlowLayout().then {
            $0.itemSize = CGSize(width: 120, height: 260)
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 10
        }
        recomendedCollectionView.collectionViewLayout = layout
    }
}

extension RecomendedTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        onItemMovieTapped?(recomendedMovies[indexPath.row].id)
    }
}

extension RecomendedTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recomendedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: RecomendedCollectionViewCell.self)
        cell.configure(movie: recomendedMovies[indexPath.row])
        return cell
    }
}
