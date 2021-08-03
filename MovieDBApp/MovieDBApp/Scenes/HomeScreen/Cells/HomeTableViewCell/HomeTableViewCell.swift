//
//  HomeTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 30/07/2021.
//

import UIKit
import Then
import Reusable

final class HomeTableViewCell: UITableViewCell, NibReusable {
    private var model: MovieSession!
    var onItemMovieTapped: ((Int) -> Void)?
    
    @IBOutlet private weak var textMovieCategory: UILabel!
    @IBOutlet private weak var buttonSeeAll: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configureUI() {
        collectionView.do {
            $0.register(cellType: HomeCollectionViewCell.self)
            $0.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            $0.showsHorizontalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
        
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.itemSize = CGSize(
                width: textMovieCategory.text == MovieCategory.nowPlaying.getTitle ?
                    contentView.frame.width : 113,
                height: textMovieCategory.text == MovieCategory.nowPlaying.getTitle ?
                    264 : 257
            )
            $0.minimumLineSpacing = 20
        }
        collectionView.collectionViewLayout = layout
    }
    
    func configure(model: MovieSession) {
        self.model = model
        textMovieCategory.text = model.category.getTitle
        configureUI()
        collectionView.reloadData()
    }
}

extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        onItemMovieTapped?(model.movies[indexPath.row].id)
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(title: model.category.getTitle, movie: model.movies[indexPath.row])
        return cell
    }
}
