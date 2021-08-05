//
//  FavoritesUseCase.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import Foundation
import RxSwift

protocol FavoriteUseCaseType {
    func getMoviesFavorite() -> Observable<[Movie]>
    func deleteFavoriteMovie(id: Int) -> Observable<Bool>
}

struct FavoriteUseCase: FavoriteUseCaseType {
    let databaseRepository: DatabaseRepositoryType
    
    func getMoviesFavorite() -> Observable<[Movie]> {
        return databaseRepository.getMoviesFavorite()
    }
    
    func deleteFavoriteMovie(id: Int) -> Observable<Bool> {
        return databaseRepository.deleteFavoriteMovie(id: id)
    }
}
