//
//  InfomationTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable

final class InfomationTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var yearRelease: UILabel!
    @IBOutlet private weak var point: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    @IBOutlet private weak var btnAddMovie: UIButton!
    
    private var isFavorite = false
    var onLikeMovieTapped: ((Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func didTapAddMovie(_ sender: Any) {        
        onLikeMovieTapped?(isFavorite)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movieDetail: MovieDetail, status: Bool) {
        isFavorite = status
        title.text = movieDetail.title
        yearRelease.text = "\(movieDetail.releaseYear.getYear()) |"
        point.text = String(movieDetail.numberRating)
        movieDescription.text = movieDetail.description
        btnAddMovie.setImage(
            status ?
                UIImage(systemName: "bookmark.fill") :
                UIImage(systemName: "bookmark"),
            for: .normal
        )
    }
}
