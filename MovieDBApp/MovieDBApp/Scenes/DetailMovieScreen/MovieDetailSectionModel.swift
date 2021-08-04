//
//  MovieDetailSectionModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import RxDataSources

enum MovieDetailSectionModel {
    case movieDetail(items: [SectionItem])
}

enum SectionItem {
    case trailer(linkId: String)
    case info(movieDetail: MovieDetail, isFavorite: Bool)
    case casts(credits: Credits)
    case movieRecommended(movie: SimilarMovies)
}

extension MovieDetailSectionModel: SectionModelType {
    typealias Item = SectionItem
    
    var items: [SectionItem] {
        switch self {
        case .movieDetail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: MovieDetailSectionModel, items: [Item]) {
        switch original {
        case .movieDetail(let items):
            self = .movieDetail(items: items)
        }
    }
}
