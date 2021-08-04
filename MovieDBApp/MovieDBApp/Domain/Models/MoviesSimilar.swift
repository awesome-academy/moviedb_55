//
//  MoviesSimilar.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import ObjectMapper

// Similar movies
struct SimilarMovies {
    var results: [Movie] = []
}

extension SimilarMovies: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results     <- map["results"]
    }
}
