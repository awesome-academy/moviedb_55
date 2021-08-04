//
//  HomeViewModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 29/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
import NSObject_Rx

struct HomeViewModel {
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<Movie>
    }
    
    struct Output {
        let movies: Driver<[MoviesSection]>
        let selectedMovieId: Driver<Movie>
    }
    
    func transform(input: Input) -> Output {
        let nowPlaying = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getMoviesByCategory(category: .nowPlaying, page: 1)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return MovieSession(category: .nowPlaying, movies: $0)
                    }
            }
        
        let upcoming = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getMoviesByCategory(category: .upcoming, page: 1)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return MovieSession(category: .upcoming, movies: $0)
                    }
            }
        
        let popular = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getMoviesByCategory(category: .popular, page: 1)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return MovieSession(category: .popular, movies: $0)
                    }
            }
        
        let topRated = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getMoviesByCategory(category: .topRated, page: 1)
                    .asDriver(onErrorJustReturn: [])
                    .map {
                        return MovieSession(category: .topRated, movies: $0)
                    }
            }
                
        let movies = Driver.combineLatest(nowPlaying, upcoming, popular, topRated)
            .map { nowPlaying, upcoming, popular, topRated -> [MoviesSection] in
                return [
                    .movies(items: [
                        .nowPlaying(model: nowPlaying),
                        .upcoming(model: upcoming),
                        .popular(mode: popular),
                        .topRated(mode: topRated)
                    ])
                ]
            }
            .asDriver(onErrorJustReturn: [])
        
        let selectedMovieId = input.selectMovieTrigger
            .do(onNext: navigator.toDetailScreen(movie:))
        
        return Output(movies: movies, selectedMovieId: selectedMovieId)
    }
}
