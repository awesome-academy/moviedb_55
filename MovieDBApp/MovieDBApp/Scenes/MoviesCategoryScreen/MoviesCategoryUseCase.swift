//
//  MoviesCategoryUseCase.swift
//  MovieDBApp
//
//  Created by Phong Le on 06/08/2021.
//

import Foundation
import RxSwift

protocol MoviesCategoryUseCaseType {
    func getMoviesByCategory(category: MovieCategory, page: Int) -> Observable<[Movie]>
}

struct MoviesCategoryUseCase: MoviesCategoryUseCaseType {
    let moviesRepository: MoviesRepositoryType
    
    func getMoviesByCategory(category: MovieCategory, page: Int) -> Observable<[Movie]> {
        return moviesRepository.getMoviesRepository(category: category, page: page)
    }
}
