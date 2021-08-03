//
//  CastAndCrewTableViewCell.swift
//  MovieDBApp
//
//  Created by Phong Le on 31/07/2021.
//

import UIKit
import Reusable
import Then

final class CastAndCrewTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var castAndCrewCollectionView: UICollectionView!
    private var casts = [Cast]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configure(credits: Credits) {
        casts = credits.cast
    }
    
    private func setupView() {
        selectionStyle = .none
        castAndCrewCollectionView.do {
            $0.register(cellType: CastAndCrewCollectionViewCell.self)
            $0.dataSource = self
        }
    }
}

extension CastAndCrewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CastAndCrewCollectionViewCell.self)
        cell.configure(cast: casts[indexPath.row])
        return cell
    }
}
