//
//  Util.swift
//  CountLab
//
//  Created by Oliver Hnát on 19.08.2024.
//

import Foundation

class Utils {
    static func formatFloat(_ number: Float) -> String {
        let formatter = Formatter.withSeparator
        return formatter.string(from: number as NSNumber) ?? "\(number)"
    }
}
