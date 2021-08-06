//
//  APIService+GetMoviesByName.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import Foundation
import RxSwift

extension APIService {
    func getMoviesByName(query: String, page: Int) -> Observable<[Movie]> {
        let url = MovieURLs.shared.getAllMovieByName(query: query, page: page)
        return APIService.shared.request(url: url, responseType: MovieResponse.self)
            .map { response -> [Movie] in
                guard let movies = response.results else { return [] }
                return movies
            }
            .catchAndReturn([])
    }
}
