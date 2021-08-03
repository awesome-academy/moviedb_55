//
//  RecomendedCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Then
import Reusable
import SDWebImage

final class RecomendedCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var movieRecomendedImage: UIImageView!
    @IBOutlet private weak var movieRecomendedTitle: UILabel!
    @IBOutlet private weak var movieRecomendedYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(movie: SimilarMovie) {
        movieRecomendedTitle.text = movie.title
        movieRecomendedYear.text = "(\(movie.releaseYear.getYear()))"
        movieRecomendedImage.loadImageWithUrl(path: movie.poster)
    }
    
    private func setupView() {
        movieRecomendedImage.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
    }
}
