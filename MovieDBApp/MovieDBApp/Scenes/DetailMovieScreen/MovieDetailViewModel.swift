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
    let movieId: Int
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectMovieTrigger: Driver<Int>
    }
    
    struct Output {
        let movieDetail: Driver<[MovieDetailSectionModel]>
        let selectedMovieId: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let movieDetail = input.loadTrigger
            .flatMapLatest {
                return useCase.getMovieDetail(id: movieId)
                    .asDriver(onErrorJustReturn: MovieDetail())
            }
            .map { movie -> [MovieDetailSectionModel] in
                return [
                    .movieDetail(items: [
                        .trailer(linkId: movie.videos.results.last?.key ?? ""),
                        .info(movieDetail: movie),
                        .casts(credits: movie.credits),
                        .movieRecommended(movie: movie.similarMovies)
                    ])
                ]
            }
        
        let selectedMovieId = input.selectMovieTrigger
            .do(onNext: navigator.toDetailScreen(id:))
        
        return Output(movieDetail: movieDetail, selectedMovieId: selectedMovieId)
    }
}
