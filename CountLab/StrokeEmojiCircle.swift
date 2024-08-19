//
//  StrokeEmojiCircle.swift
//  CountLab
//
//  Created by Oliver Hnát on 19.08.2024.
//

import SwiftUI

struct StrokeEmojiCircle: View {
    var emoji: String
    var backgroundColor: Color

    @Binding var done: Float?
    var goal: Float?
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(done! / goal!))
                .stroke(backgroundColor.opacity(5000), lineWidth: 20)
                .rotationEffect(.degrees(-90))
                .brightness(-0.1)
            EmojiCircle(emoji: emoji, backgroundColor: backgroundColor)
        }
    }
}

#Preview {
    StrokeEmojiCircle(emoji: "🐱", backgroundColor: Color.red.opacity(0.2), done: Binding.constant(5), goal: 10)
}
