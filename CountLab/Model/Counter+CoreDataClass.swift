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
}


