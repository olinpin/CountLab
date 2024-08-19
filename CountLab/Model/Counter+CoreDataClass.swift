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

}


extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }

    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
    var hex: String {
            let components = UIColor(self).cgColor.components
            let r = Float(components?[0] ?? 0)
            let g = Float(components?[1] ?? 0)
            let b = Float(components?[2] ?? 0)
            let a = Float(components?[3] ?? 1)

            if a < 1 {
                return String(format: "#%02lX%02lX%02lX%02lX",
                              lroundf(a * 255),
                              lroundf(r * 255),
                              lroundf(g * 255),
                              lroundf(b * 255))
            } else {
                return String(format: "#%02lX%02lX%02lX",
                              lroundf(r * 255),
                              lroundf(g * 255),
                              lroundf(b * 255))
            }
        }
}
