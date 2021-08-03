//
//  HomeUseCase.swift
//  MovieDBApp
//
//  Created by Phong Le on 29/07/2021.
//

import Foundation
import RxSwift

protocol HomeUseCaseType {
    func getMoviesByCategory(category: MovieCategory, page: Int) -> Observable<[Movie]>
}

struct HomeUseCase: HomeUseCaseType {
    let moviesRepository: MoviesRepositoryType
    
    func getMoviesByCategory(category: MovieCategory, page: Int) -> Observable<[Movie]> {
        return moviesRepository.getMoviesRepository(category: category, page: page)
    }
}
