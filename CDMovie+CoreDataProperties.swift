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

    @NSManaged public var id: Int16
    @NSManaged public var originalTitle: String?
    @NSManaged public var overview: String?
    @NSManaged public var posterURL: Data?

}

extension CDMovie : Identifiable {

}
