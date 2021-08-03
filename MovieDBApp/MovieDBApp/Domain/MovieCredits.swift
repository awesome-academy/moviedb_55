//
//  MovieCredits.swift
//  MovieDBApp
//
//  Created by Phong Le on 03/08/2021.
//

import Foundation
import ObjectMapper

struct Cast {
    var name: String = ""
    var image: String = ""
}

extension Cast: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        name        <- map["name"]
        image       <- map["profile_path"]
    }
}

struct Credits {
    var cast: [Cast] = []
}

extension Credits: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        cast        <- map["cast"]
    }
}
