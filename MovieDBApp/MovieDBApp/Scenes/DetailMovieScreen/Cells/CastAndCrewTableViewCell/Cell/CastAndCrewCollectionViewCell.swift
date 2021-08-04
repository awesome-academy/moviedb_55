//
//  CastAndCrewCollectionViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable
import Then
import SDWebImage

final class CastAndCrewCollectionViewCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var castName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(cast: Cast) {
        castName.text = cast.name
        castImage.loadImageWithUrl(path: cast.image)
    }
    
    private func setupView() {
        castImage.do {
            $0.layer.cornerRadius = $0.frame.height / 2
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
        }
    }
}
