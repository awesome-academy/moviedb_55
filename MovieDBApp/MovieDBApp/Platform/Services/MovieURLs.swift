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
    
    private init() {}
    
    func getAllMovieByCategory(category: String, page: Int) -> String {
        return "\(baseURL)/movie/\(category)?language=en-US&page=\(page)"
    }
}
