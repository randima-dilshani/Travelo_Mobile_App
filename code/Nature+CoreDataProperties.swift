//
//  Nature+CoreDataProperties.swift
//  NatureNut
//
//  Created by Randima Dilshani on 2023-06-15.
//
//

import Foundation
import CoreData


extension Nature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Nature> {
        return NSFetchRequest<Nature>(entityName: "Nature")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var kilometers: Double
    @NSManaged public var name: String?
    @NSManaged public var place: String?
    @NSManaged public var selectedimage: Data?
    @NSManaged public var type: String?

}

extension Nature : Identifiable {

}
