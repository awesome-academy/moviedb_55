//
//  HomeCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 06/08/2021.
//

import UIKit
import Then
import SDWebImage
import Reusable
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell, NibReusable {
    private var titleCategory = ""
    
    private let movieImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let movieTitle = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let movieYearRelease = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieImageView.image = nil
        movieTitle.text = nil
        movieYearRelease.text = nil
    }
    
    func configure(title: String, movie: Movie) {
        titleCategory = title
        movieImageView.loadImageWithUrl(urlImage: .poster, path: movie.poster)
        movieTitle.text = movie.title
        movieYearRelease.text = "(\(movie.dayRelease.getYear()))"
        configureUI()
    }
    
    private func configureUI() {
        contentView.do {
            $0.addSubview(movieImageView)
            $0.addSubview(movieTitle)
            $0.addSubview(movieYearRelease)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        movieImageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.top.equalTo(contentView).offset(10)
            $0.height.equalTo(contentView).multipliedBy(0.7)
        }
        
        movieTitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView)
            $0.top.equalTo(movieImageView.snp_bottomMargin).offset(10)
        }
        
        movieYearRelease.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(movieTitle.snp_bottomMargin).offset(10)
        }
    }
}
