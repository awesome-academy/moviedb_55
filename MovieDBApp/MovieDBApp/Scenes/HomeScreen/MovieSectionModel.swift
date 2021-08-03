//
//  MovieSectionModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 30/07/2021.
//

import Foundation
import RxDataSources

enum MoviesSection {
    case movies(items: [SectionItemMovie])
}

enum SectionItemMovie {
    case nowPlaying(model: MovieSession)
    case upcoming(model: MovieSession)
    case popular(mode: MovieSession)
    case topRated(mode: MovieSession)
}

extension MoviesSection: SectionModelType {
    typealias Item = SectionItemMovie
    
    var items: [SectionItemMovie] {
        switch self {
        case .movies(let items):
            return items.map { $0 }
        }
    }
    
    init(original: MoviesSection, items: [Item]) {
        switch original {
        case .movies(let items):
            self = .movies(items: items)
        }
    }
}
