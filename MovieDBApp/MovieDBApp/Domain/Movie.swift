//
//  Movie.swift
//  MovieDBApp
//
//  Created by Phong Le on 28/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct MovieResponse: Mappable {
    var results: [Movie]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        results     <- map["results"]
    }
}

struct Movie {
    var id: Int
    var title: String
    var description: String
    var poster: String
    var vote: Int
    var dayRelease: String
}

extension Movie {
    init() {
        self.init(id: 0,
                  title: "",
                  description: "",
                  poster: "",
                  vote: 0,
                  dayRelease: "")
    }
}

extension Movie: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id          <- map["id"]
        title       <- map["title"]
        description <- map["overview"]
        poster      <- map["poster_path"]
        vote        <- map["vote_average"]
        dayRelease  <- map["release_date"]
    }
}
