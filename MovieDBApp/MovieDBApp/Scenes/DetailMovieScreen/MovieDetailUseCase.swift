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
    func isMoveFavorite(id: Int) -> Observable<Bool>
    func addFavoriteMovie(movie: Movie) -> Observable<Bool>
    func deleteFavoriteMovie(id: Int) -> Observable<Bool>
}

struct MovieDetailUseCase: MovieDetailUseCaseType {
    let movieRepository: MoviesRepositoryType
    let databaseRepository: DatabaseRepositoryType
    
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        return movieRepository.getMovieDetail(id: id)
    }
    
    func isMoveFavorite(id: Int) -> Observable<Bool> {
        return databaseRepository.isMovieFavorite(id: id)
    }
    
    func addFavoriteMovie(movie: Movie) -> Observable<Bool> {
        return databaseRepository.addFavoriteMovie(movie: movie)
    }
    
    func deleteFavoriteMovie(id: Int) -> Observable<Bool> {
        return databaseRepository.deleteFavoriteMovie(id: id)
    }
}
