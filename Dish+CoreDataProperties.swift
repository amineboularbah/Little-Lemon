//
//  Dish+CoreDataProperties.swift
//  Little Lemon
//
//  Created by Amine on 22/11/2024.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var image: String?
    @NSManaged public var price: String?
    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var dishDescription: String?

}

extension Dish : Identifiable {

}
