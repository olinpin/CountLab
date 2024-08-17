//
//  EmojiCircle.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI

struct EmojiCircle: View {
    var emoji: String
    var backgroundColor: Color
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(backgroundColor)
            Text(emoji)
                .font(.system(size: 10000))
                .minimumScaleFactor(0.0001)
                .lineLimit(1)
                .padding()
        }
        .padding()
        .ignoresSafeArea()
    }
}

#Preview {
    EmojiCircle(emoji: "🐱", backgroundColor: Color.red.opacity(0.2))
}
