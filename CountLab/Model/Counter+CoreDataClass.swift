//
//  Counter+CoreDataClass.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Counter)
public class Counter: NSManagedObject {

    func doneToday() -> Float {
        let sum: [Float] = self.log?.map( {
            let log = $0 as! Log
            if log.timestamp != nil && log.timestamp!.isToday {
                return log.value
            }
            return 0
        }) ?? []
        return sum.reduce(0, +)
    }
    
    func doneTotal() -> Float {
        let sum: [Float] = self.log?.map( {
            let log = $0 as! Log
            return log.value
        }) ?? []
        return sum.reduce(0, +)
    }
    
    func averagePerDay() -> Float {
        let first = self.firstEntry()
        if first == nil {
            return 0
        }
        let daysSinceFirst = first!.timestamp!.daysSince + 1
        return self.doneTotal() / Float(daysSinceFirst)
    }
    
    func firstEntry() -> Log? {
        let logs: [Log] = (self.log?.allObjects as! [Log]).sorted(by: {$0.timestamp ?? Date() < $1.timestamp ?? Date()})
        return logs.first
    }
}


