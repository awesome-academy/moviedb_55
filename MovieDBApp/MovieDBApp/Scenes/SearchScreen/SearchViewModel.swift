//
//  SearchViewModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 05/08/2021.
//

import UIKit
import RxSwift
import RxCocoa

struct SearchViewModel {
    let useCase: SearchUseCaseType
    let navigator: SearchNavigatorType
    
    struct Input {
        let searchBarTrigger: Driver<String>
        let loadMoreTrigger: Driver<Int>
        let selectMovieTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let movies: Driver<[Movie]>
        let moviesDriver: [Driver<[Movie]>]
        let movieSelected: Driver<Movie>
        let notFoundMovie: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let dataSource = BehaviorRelay<[Movie]>(value: [])
        let handleQuery = BehaviorRelay<String>(value: "")
        let notFoundMovie = BehaviorRelay<Bool>(value: true)
        
        let moviesSearched = input.searchBarTrigger
            .map { $0.replacingOccurrences(of: " ", with: "%20") }
            .do(onNext: handleQuery.accept(_:))
            .flatMapLatest { query in
                return useCase.getMoviesByName(query: query, page: 1)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: {
                dataSource.accept($0)
                
                if $0.isEmpty && !handleQuery.value.isEmpty {
                    notFoundMovie.accept(false)
                } else if !$0.isEmpty {
                    notFoundMovie.accept(true)
                }
            })
        
        let moviesLoadMore = input.loadMoreTrigger
            .flatMapLatest { page in
                return useCase.getMoviesByName(query: handleQuery.value, page: page)
                    .asDriver(onErrorJustReturn: [])
            }
            .do(onNext: {
                dataSource.accept(dataSource.value + $0)
            })
        
        let moviesDriver = [moviesSearched, moviesLoadMore]
        
        let movieSelected = input.selectMovieTrigger
            .withLatestFrom(dataSource.asDriver()) { (indexPath, movies) -> Movie in
                return movies[indexPath.row]
            }
            .do(onNext: navigator.toDetailScreen(movie:))
                
        return Output(movies: dataSource.asDriver(),
                      moviesDriver: moviesDriver,
                      movieSelected: movieSelected,
                      notFoundMovie: notFoundMovie.asDriver())
    }
}
