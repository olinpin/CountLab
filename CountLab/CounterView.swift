//
//  CounterView.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI
import CoreData

struct CounterView: View {
    
    var counter: Counter
    var body: some View {
        EmojiCircle(
            emoji: counter.emoji ?? "",
            backgroundColor: Color.init(hex:counter.backgroundColor ?? "#FFFFFF") ?? Color(UIColor.systemBackground)
        )
        .padding()
    }
}

#Preview {
    let request = Counter.fetchRequest()
    do {
        let counters = try PersistenceController.preview.container.viewContext.fetch(request)
        return CounterView(counter: counters.first!)
    } catch {
    }
    return CounterView(counter: Counter(context: PersistenceController.preview.container.viewContext))
}
