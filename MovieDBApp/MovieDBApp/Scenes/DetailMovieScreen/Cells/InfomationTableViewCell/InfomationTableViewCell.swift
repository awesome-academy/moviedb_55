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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movieDetail: MovieDetail) {
        title.text = movieDetail.title
        yearRelease.text = "\(movieDetail.releaseYear.getYear()) |"
        point.text = String(movieDetail.numberRating)
        movieDescription.text = movieDetail.description
    }
}
