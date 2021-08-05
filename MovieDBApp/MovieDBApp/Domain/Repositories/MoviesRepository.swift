//
//  MoviesRepository.swift
//  MovieDBApp
//
//  Created by Phong Le on 29/07/2021.
//

import Foundation
import RxSwift

protocol MoviesRepositoryType {
    func getMoviesRepository(category: MovieCategory, page: Int) -> Observable<[Movie]>
    func getMovieDetail(id: Int) -> Observable<MovieDetail>
    func getMoviesByName(query: String, page: Int) -> Observable<[Movie]>
}

struct MoviesRepository: MoviesRepositoryType {
    func getMoviesRepository(category: MovieCategory, page: Int) -> Observable<[Movie]> {
        return APIService.shared.getMoviesByCategory(category: category, page: page)
    }
    
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        return APIService.shared.getMovieDetail(id: id)
    }
    
    func getMoviesByName(query: String, page: Int) -> Observable<[Movie]> {
        return APIService.shared.getMoviesByName(query: query, page: page)
    }
}
