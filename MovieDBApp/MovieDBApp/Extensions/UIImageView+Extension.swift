//
//  UIImageView+Extension.swift
//  MovieDBApp
//
//  Created by Phong Le on 29/07/2021.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithUrl(path: String) {
        self.sd_setImage(with: URL(string: MovieURLs.shared.baseImageURL + path))
    }
}
