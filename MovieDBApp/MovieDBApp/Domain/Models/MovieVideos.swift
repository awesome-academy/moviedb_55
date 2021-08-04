//
//  MovieVideos.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import ObjectMapper

// Videos
struct MovieVideo {
    var key: String = ""
}

extension MovieVideo: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        key     <- map["key"]
    }
}

struct MovieVideos {
    var results: [MovieVideo] = []
}

extension MovieVideos: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        results     <- map["results"]
    }
}
