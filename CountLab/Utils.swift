//
//  Util.swift
//  CountLab
//
//  Created by Oliver Hnát on 19.08.2024.
//

import Foundation
import SwiftUI

class Utils {
    static func formatFloat(_ number: Float) -> String {
        let formatter = Formatter.withSeparator
        return formatter.string(from: number as NSNumber) ?? "\(number)"
    }
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
            a = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            r = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x000000FF) / 255.0

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
    
    func luminance() -> CGFloat {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0, 1]
        let red = components[0] * 0.299
        let green = components[1] * 0.587
        let blue = components[2] * 0.114
        return red + green + blue
    }
    
    func appropriateTextColor() -> Color {
        return luminance() > 0.5 ? .black : .white
    }
}

let numberOfDecimalDigits = 2

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal

        // minimum decimal digit, eg: to display 2.00 as 2
        formatter.minimumFractionDigits = 0

        // maximum decimal digit, eg: to display 2.5021 as 2.50
        formatter.maximumFractionDigits = numberOfDecimalDigits
        
        return formatter
    }()
}

extension Date {
    var isToday: Bool {
        let today = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let date = Calendar.current.dateComponents([.day, .year, .month], from: self)
        return today.day == date.day && today.month == date.month && today.year == date.year
        
    }
    var DDMMYYYY: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
