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
    let movieId: Int
    
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let movieDetail: Driver<[MovieDetailSectionModel]>
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
                        .info(name: movie.title,
                              year: movie.releaseYear.getYear(),
                              numberRating: movie.numberRating,
                              description: movie.description),
                        .casts(credits: movie.credits),
                        .movieRecommended(movie: movie.similarMovies)
                    ])
                ]
            }
        
        return Output(movieDetail: movieDetail)
    }
}
