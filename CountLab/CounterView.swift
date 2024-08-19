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
    
    var goal: Float = 10
    
    @State var done: Float = 0
    
    var body: some View {
        VStack {
            StrokeEmojiCircle(
                emoji: counter.emoji ?? "",
                backgroundColor: Color.init(hex:counter.backgroundColor ?? "#FFFFFF") ?? Color(UIColor.systemBackground),
                done: $done,
                goal: goal
            )
                .padding(.bottom)
            Text("Total: \(Utils.formatFloat(self.done))/\(Utils.formatFloat(self.goal))")
                .font(.largeTitle)
            QuantityButtons(sum: $done)
                .padding(.top)
        }
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
