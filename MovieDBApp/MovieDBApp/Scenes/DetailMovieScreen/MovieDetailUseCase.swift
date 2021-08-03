//
//  MovieDetailUseCase.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import RxSwift

protocol MovieDetailUseCaseType {
    func getMovieDetail(id: Int) -> Observable<MovieDetail>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieRepository: MoviesRepositoryType
    
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        return movieRepository.getMovieDetail(id: id)
    }
}
