//
//  MoviesCategoryViewModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 06/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MoviesCategoryViewModel {
    let useCase: MoviesCategoryUseCaseType
    let navigator: MoviesCategoryNavigatorType
    var category: MovieCategory
    
    struct Input {
        let loadMoreTrigger: Driver<Int>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let voidDrivers: [Driver<Void>]
    }
    
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[Movie]>(value: [])
        
        let moviesLoadMore = input.loadMoreTrigger
            .flatMapLatest { page in
                return useCase.getMoviesByCategory(category: category, page: page)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: {
                dataSource.accept(dataSource.value + $0)
            })
            .map { _ in }
        
        let selectedMovie = input.selectMovieTrigger
            .withLatestFrom(dataSource.asDriver()) { (indexPath, movies) in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.toDetailScreen(movie:))
            .map { _ in }
        
        return Output(movies: dataSource.asDriver(),
                      voidDrivers: [moviesLoadMore, selectedMovie])
    }
}
