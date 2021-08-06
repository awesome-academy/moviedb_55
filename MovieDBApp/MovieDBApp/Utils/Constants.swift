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

enum DatabaseError: Error {
    case addMovieFailed
    case deleteMovieFailed
    case checkMovieExistFailed
    case getAllMovieFailed
}

enum DatabaseAlert {
    case addSuccessfully
    case deleteSuccessfully
    
    var message: String {
        switch self {
        case .addSuccessfully:
            return "Add Movie Successfully!"
        case .deleteSuccessfully:
            return "Delete Movie Successfully!"
        }
    }
}

enum MovieImage {
    case poster
    case backdrop
    
    var getImageURL: String {
        switch self {
        case .poster:
            return MovieURLs.shared.baseImageURL + "w200"
        case .backdrop:
            return MovieURLs.shared.baseImageURL + "w400"
        }
    }
}
