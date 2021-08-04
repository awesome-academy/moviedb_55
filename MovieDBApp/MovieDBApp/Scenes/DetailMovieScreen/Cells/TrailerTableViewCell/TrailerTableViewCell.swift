//
//  TrailerTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import UIKit
import youtube_ios_player_helper
import Reusable

final class TrailerTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var videoTrailer: YTPlayerView!
    private var linkId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async { [unowned self] in
            videoTrailer.load(withVideoId: linkId)
        }
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(linkId: String) {
        self.linkId = linkId
    }
    
    private func setupView() {
        selectionStyle = .none
        videoTrailer.backgroundColor = .black
    }
}
