//
//  Roll+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Milo Wyner on 10/11/21.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var sides: Int16
    @NSManaged public var dice: [Int]?
    @NSManaged public var timestamp: Date?

}

extension Roll : Identifiable {

}
