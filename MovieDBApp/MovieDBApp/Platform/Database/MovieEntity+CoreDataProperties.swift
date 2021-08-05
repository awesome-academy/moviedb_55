//
//  MovieEntity+CoreDataProperties.swift
//  MovieDBApp
//
//  Created by Phong Le on 04/08/2021.
//
//

import Foundation
import CoreData

extension MovieEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var vote: Double
    @NSManaged public var dayRelease: String?
    @NSManaged public var title: String?
    @NSManaged public var poster: String?
    @NSManaged public var backdrop: String?
    @NSManaged public var overview: String?
}

extension MovieEntity : Identifiable {}
