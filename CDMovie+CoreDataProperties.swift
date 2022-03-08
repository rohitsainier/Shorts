//
//  CDMovie+CoreDataProperties.swift
//  Shorts
//
//  Created by Rohit Saini on 07/03/22.
//
//

import Foundation
import CoreData


extension CDMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDMovie> {
        return NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged public var id: Double
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterURL: Data?
    
    
    func convertToMovie() -> Movie{
        return Movie(originalTitle: self.originalTitle, posterPath: "", overview: self.overview ?? "", releaseDate: "", id: Int(self.id), movieImageData: self.posterURL)
    }

}

extension CDMovie : Identifiable {

}
