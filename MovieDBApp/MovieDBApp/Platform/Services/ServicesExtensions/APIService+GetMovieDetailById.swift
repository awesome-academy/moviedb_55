//
//  APIService+GetMovieDetailById.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import RxSwift

extension APIService {
    func getMovieDetail(id: Int) -> Observable<MovieDetail> {
        let url = MovieURLs.shared.getMovieDetailById(id: id)
        return request(url: url, responseType: MovieDetail.self)
    }
}
