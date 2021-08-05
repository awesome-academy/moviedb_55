//
//  FavoritesViewModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct FavoritesViewModel {
    let useCase: FavoriteUseCase
    let navigator: FavoritesNavigatorType
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<IndexPath>
        let movieDeleteTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let moviesFavorite: Driver<[Movie]>
        let movieSelected: Driver<Movie>
        let movieDeleted: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[Movie]>(value: [])
        
        let moviesFavorites = input.loadTrigger
            .flatMapLatest {  _ in
                return useCase.getMoviesFavorite()
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: dataSource.accept(_:))
        
        let movieSelected = input.selectMovieTrigger
            .withLatestFrom(moviesFavorites) { (indexPath, movies) in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.toDetailScreen(movie:))
        
        let movieDeleted = input.movieDeleteTrigger
            .flatMapLatest { indexPath in
                return useCase.deleteFavoriteMovie(id: dataSource.value[indexPath.row].id)
                    .asDriver(onErrorDriveWith: .empty())
            }
        
        return Output(
            moviesFavorite: moviesFavorites,
            movieSelected: movieSelected,
            movieDeleted: movieDeleted
        )
    }
}
