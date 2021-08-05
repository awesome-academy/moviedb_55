//
//  SearchTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit
import Then
import Reusable

final class SearchTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet private weak var movieYear: UILabel!
    @IBOutlet private weak var movieName: UILabel!
    @IBOutlet private weak var movieNumber: UILabel!
    @IBOutlet private weak var backgroundLayer: UIView!
    @IBOutlet private weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        backgroundLayer.do {
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
        
        backgroundImage.do {
            $0.clipsToBounds = true
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
