//
//  APIService+GetMovieByCategory.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import UIKit
import RxSwift

extension APIService {
    func fetchMovies(category: String, page: Int) -> Observable<[Movie]> {
        let URL = MovieURLs.shared.getAllMovieByCategory(category: category, page: page)
        return request(URL: URL, responseType: MovieResponse.self)
            .map { response -> [Movie] in
                guard let movies = response.results else { return [] }
                return movies
            }
            .catchAndReturn([])
    }
}
