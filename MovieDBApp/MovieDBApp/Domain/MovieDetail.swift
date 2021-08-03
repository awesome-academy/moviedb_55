//
//  MovieDetail.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import ObjectMapper

// Movie detail
struct MovieDetail {
    var id: Int
    var title: String
    var description: String
    var releaseYear: String
    var numberRating: Double
    var videos: MovieVideos
    var credits: Credits
    var similarMovies: SimilarMovies
}

extension MovieDetail {
    init() {
        self.init(id: 0, title: "", description: "", releaseYear: "", numberRating: 0,
                  videos: MovieVideos(), credits: Credits(), similarMovies: SimilarMovies())
    }
}

extension MovieDetail: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        description     <- map["overview"]
        releaseYear     <- map["release_date"]
        numberRating    <- map["vote_average"]
        videos          <- map["videos"]
        credits         <- map["credits"]
        similarMovies   <- map["similar_movies"]
    }
}

