//
//  SearchUseCase.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import Foundation
import RxSwift

protocol SearchUseCaseType {
    func getMoviesByName(query: String, page: Int) -> Observable<[Movie]>
}

struct SearchUseCase: SearchUseCaseType {
    let moviesRepository: MoviesRepositoryType
    
    func getMoviesByName(query: String, page: Int) -> Observable<[Movie]> {
        return moviesRepository.getMoviesByName(query: query, page: page)
    }
}
