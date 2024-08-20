//
//  StrokeEmojiCircle.swift
//  CountLab
//
//  Created by Oliver Hnát on 19.08.2024.
//

import SwiftUI

struct StrokeEmojiCircle: View {
    var counter: Counter
    var done: Float
    var geometry: GeometryProxy?
    // TODO: part of circle is see through
    var body: some View {
        let backgroundColor = Color.init(hex:counter.backgroundColor ?? "#FFFFFF") ?? Color(UIColor.systemBackground)
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(done / counter.goal))
                .stroke(backgroundColor.opacity(5000), lineWidth: (geometry != nil) ? min(geometry!.size.height, geometry!.size.width) / 10 : 20)
                .rotationEffect(.degrees(-90))
                .brightness(-0.1)
            EmojiCircle(emoji: counter.emoji ?? "", backgroundColor: backgroundColor)
        }
    }
}

#Preview {
    let request = Counter.fetchRequest()
    do {
        let counters = try PersistenceController.preview.container.viewContext.fetch(request)
//        return StrokeEmojiCircle(counter: counters.first!, done: Float(0.5))
    } catch {
    }
    return StrokeEmojiCircle(counter: Counter(context: PersistenceController.preview.container.viewContext), done: 0.5)
}
