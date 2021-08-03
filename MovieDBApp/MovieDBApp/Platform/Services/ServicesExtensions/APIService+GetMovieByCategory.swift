//
//  APIService+GetMovieByCategory.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import UIKit
import RxSwift

extension APIService {
    func getMoviesByCategory(category: MovieCategory, page: Int) -> Observable<[Movie]> {
        let url = MovieURLs.shared.getAllMovieByCategory(category: category, page: page)
        return request(url: url, responseType: MovieResponse.self)
            .map { response -> [Movie] in
                guard let movies = response.results else { return [] }
                return movies
            }
            .catchAndReturn([])
    }
}
