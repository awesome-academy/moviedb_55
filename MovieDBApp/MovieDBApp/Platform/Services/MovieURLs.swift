//
//  MovieURLs.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import Foundation

struct MovieURLs {
    static let shared = MovieURLs()
    
    private let baseURL = "https://api.themoviedb.org/3"
    let baseImageURL = "https://image.tmdb.org/t/p/w200"
    
    private init() {}
    
    func getAllMovieByCategory(category: MovieCategory, page: Int) -> String {
        return "\(baseURL)/movie/\(category.rawValue)?language=en-US&page=\(page)"
    }
    
    func getMovieDetailById(id: Int) -> String {
        return "\(baseURL)/movie/\(id)?append_to_response=videos,similar_movies,credits"
    }
}
