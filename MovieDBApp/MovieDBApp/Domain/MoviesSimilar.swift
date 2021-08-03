//
//  MoviesSimilar.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import ObjectMapper

// Similar movies
struct SimilarMovie {
    var id: Int
    var title: String
    var poster: String
    var releaseYear: String
}

extension SimilarMovie {
    init() {
        self.init(id: 0, title: "", poster: "", releaseYear: "")
    }
}

extension SimilarMovie: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        poster      <- map["poster_path"]
        releaseYear <- map["release_date"]
    }
}

struct SimilarMovies {
    var results: [SimilarMovie] = []
}

extension SimilarMovies: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results     <- map["results"]
    }
}
