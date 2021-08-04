//
//  MovieDetailViewModel.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct MovieDetailViewModel {
    let useCase: MovieDetailUseCaseType
    let navigator: MovieDetailNavigatorType
    let movie: Movie
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<Movie>
        let likeMovieTrigger: Driver<Bool>
    }
    
    struct Output {
        let movieDetail: Driver<[MovieDetailSectionModel]>
        let selectedMovieId: Driver<Movie>
        let handleStatus: [Driver<Bool>]
    }
    
    func transform(input: Input) -> Output {
        let handleLike = BehaviorRelay<Bool>(value: false)
        
        let isFavoriteMovie = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.isMoveFavorite(id: movie.id)
                    .asDriver(onErrorDriveWith: .empty())
            }
            .do(onNext: handleLike.accept(_:))
        
        let likeFavoriteMovie = input.likeMovieTrigger
            .flatMapLatest { status in
                return status
                    ? useCase.deleteFavoriteMovie(id: movie.id).asDriver(onErrorDriveWith: .empty())
                    : useCase.addFavoriteMovie(movie: movie).asDriver(onErrorDriveWith: .empty())
            }
            .do(onNext: handleLike.accept(_:))
        
        let movieDetail = input.loadTrigger
            .flatMapLatest {
                return useCase.getMovieDetail(id: movie.id)
                    .asDriver(onErrorJustReturn: MovieDetail())
            }
            
        let combineMovieDetailAndLike = Driver.combineLatest(handleLike.asDriver(), movieDetail)
            .map { status, movie -> [MovieDetailSectionModel] in
                return [
                    .movieDetail(items: [
                        .trailer(linkId: movie.videos.results.last?.key ?? ""),
                        .info(movieDetail: movie, isFavorite: status),
                        .casts(credits: movie.credits),
                        .movieRecommended(movie: movie.similarMovies)
                    ])
                ]
            }
        
        let selectedMovieId = input.selectMovieTrigger
            .do(onNext: navigator.toDetailScreen(movie:))
        
        let handleStatus = [isFavoriteMovie, likeFavoriteMovie]
        
        return Output(movieDetail: combineMovieDetailAndLike,
                      selectedMovieId: selectedMovieId,
                      handleStatus: handleStatus)
    }
}
