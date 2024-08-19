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
        Circle()
            .foregroundStyle(backgroundColor)
            .overlay {
                Text(emoji)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.001)
            }
            .ignoresSafeArea()
    }
}

#Preview {
    EmojiCircle(emoji: "🐱", backgroundColor: Color.red.opacity(0.2))
}
