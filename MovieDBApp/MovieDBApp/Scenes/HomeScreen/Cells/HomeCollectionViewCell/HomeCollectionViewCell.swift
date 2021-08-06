//
//  HomeCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 30/07/2021.
//

import UIKit
import Then
import SDWebImage
import Reusable
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell, NibReusable {
    private var titleCategory = ""
    
    private let movieImageViewBackground = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        movieImageViewBackground.image = nil
        movieImageView.image = nil
        movieTitle.text = nil
        movieYearRelease.text = nil
    }
    
    func configure(title: String, movie: Movie) {
        titleCategory = title
        movieImageViewBackground.loadImageWithUrl(urlImage: .poster, path: movie.poster)
        movieImageView.loadImageWithUrl(urlImage: .poster, path: movie.poster)
        movieTitle.text = title == MovieCategory.nowPlaying.getTitle ? "" : movie.title
        movieYearRelease.text = title == MovieCategory.nowPlaying.getTitle ? "" : "(\(movie.dayRelease.getYear()))"
        configureUI()
    }
    
    private func configureUI() {
        if titleCategory == MovieCategory.nowPlaying.getTitle {
            let blur = UIBlurEffect(style: .light)
            let blurView = UIVisualEffectView(effect: blur).then {
                $0.frame = contentView.bounds
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 10
            }
            
            contentView.do {
                $0.addSubview(movieImageViewBackground)
                $0.addSubview(blurView)
            }
        }
        contentView.do {
            $0.addSubview(movieImageView)
            $0.addSubview(movieTitle)
            $0.addSubview(movieYearRelease)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if titleCategory != MovieCategory.nowPlaying.getTitle {
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
        } else {
            movieImageViewBackground.snp.makeConstraints {
                $0.leading.trailing.equalTo(contentView)
                $0.top.equalTo(contentView).offset(10)
                $0.height.equalTo(contentView).multipliedBy(0.9)
            }
            
            movieImageView.snp.makeConstraints {
                $0.centerX.centerY.equalTo(movieImageViewBackground)
                $0.width.equalTo(movieImageViewBackground).multipliedBy(225 / contentView.bounds.width)
                $0.height.equalTo(movieImageViewBackground).multipliedBy(244 / contentView.bounds.height)
            }
        }
    }
}
