//
//  Constants.swift
//  MovieDBApp
//
//  Created by Phong Le on 30/07/2021.
//

enum MovieCategory: String, CaseIterable {
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case popular = "popular"
    case topRated = "top_rated"
    case none = ""
    
    var getTitle: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .upcoming:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .none:
            return ""
        }
    }
}