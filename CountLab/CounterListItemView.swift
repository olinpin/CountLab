//
//  CounterListItemView.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI

struct CounterListItemView: View {
    var counter: Counter
    
    var body: some View {
        HStack {
            StrokeEmojiCircle(counter: counter, done: counter.doneToday())
            Text("\(counter.name ?? "")")
                .font(.title2)
                .padding()
        }
        .padding()
    }
}

var numberOfDecimalDigits = 2


#Preview {
    let request = Counter.fetchRequest()
    do {
        let counters = try PersistenceController.preview.container.viewContext.fetch(request)
        return List {
            CounterListItemView(counter: counters.first!)
        }
    } catch {
    }
    return CounterListItemView(counter: Counter(context: PersistenceController.preview.container.viewContext))
}
