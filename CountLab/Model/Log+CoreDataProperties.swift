//
//  Log+CoreDataProperties.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var value: Float
    @NSManaged public var counter: Counter?

}

extension Log : Identifiable {

}
