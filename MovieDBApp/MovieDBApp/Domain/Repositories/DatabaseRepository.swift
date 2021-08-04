//
//  DatabaseRepository.swift
//  MovieDBApp
//
//  Created by Phong Le on 04/08/2021.
//

import Foundation
import RxSwift

protocol DatabaseRepositoryType {
    func isMovieFavorite(id: Int) -> Observable<Bool>
    func addFavoriteMovie(movie: Movie) -> Observable<Bool>
    func deleteFavoriteMovie(id: Int) -> Observable<Bool>
}

struct DatabaseRepository: DatabaseRepositoryType {
    func isMovieFavorite(id: Int) -> Observable<Bool> {
        return DatabaseManager.shared.checkMovieExist(id: id)
    }
    
    func addFavoriteMovie(movie: Movie) -> Observable<Bool> {
        return DatabaseManager.shared.addFavoriteMovie(movie: movie)
    }
    
    func deleteFavoriteMovie(id: Int) -> Observable<Bool> {
        return DatabaseManager.shared.deleteFavoriteMovie(id: id)
    }
}
