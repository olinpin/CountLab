//
//  Counter+CoreDataProperties.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//
//

import Foundation
import CoreData


extension Counter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counter> {
        return NSFetchRequest<Counter>(entityName: "Counter")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var emoji: String?
    @NSManaged public var goal: Float
    @NSManaged public var name: String?
    @NSManaged public var log: NSSet?

}

// MARK: Generated accessors for log
extension Counter {

    @objc(addLogObject:)
    @NSManaged public func addToLog(_ value: Log)

    @objc(removeLogObject:)
    @NSManaged public func removeFromLog(_ value: Log)

    @objc(addLog:)
    @NSManaged public func addToLog(_ values: NSSet)

    @objc(removeLog:)
    @NSManaged public func removeFromLog(_ values: NSSet)

}

extension Counter : Identifiable {

}
