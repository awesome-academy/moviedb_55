//
//  UIImageView+Extension.swift
//  MovieDBApp
//
//  Created by Phong Le on 29/07/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithUrl(urlImage: MovieImage, path: String) {
        self.image = UIImage(named: "imageNotFound")
        if !path.isEmpty {
            self.sd_setImage(with: URL(string: urlImage.getImageURL + path))
        }
    }
}
