//
//  FavoritesCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit
import Then
import Reusable

final class FavoritesCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageMovieFavorite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupView() {
        imageMovieFavorite.do {
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
            $0.contentMode = .scaleAspectFill
        }
    }
}
