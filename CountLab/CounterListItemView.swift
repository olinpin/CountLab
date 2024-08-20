//
//  CounterListItemView.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI

struct CounterListItemView: View {
    @ObservedObject var counter: Counter
    var doneToday: Float {
        let sum: [Float] = counter.log?.map( {
            let log = $0 as! Log
            if log.timestamp != nil && log.timestamp!.isToday {
                return log.value
            }
            return 0
        }) ?? []
        return sum.reduce(0, +)
    }

    var body: some View {
        GeometryReader { geometry in
            HStack {
                StrokeEmojiCircle(counter: counter, done: counter.doneToday(), geometry: geometry)
                Text("\(counter.name ?? "")")
                    .font(.title2)
                    .padding()
            }
            .padding()
        }
    }
}

#Preview {
    let request = Counter.fetchRequest()
    do {
        let counters = try PersistenceController.preview.container.viewContext.fetch(request)
        return List {
            CounterListItemView(counter: counters.first!)
                .frame(height: 100)
        }
    } catch {
    }
    return CounterListItemView(counter: Counter(context: PersistenceController.preview.container.viewContext))
        .frame(height: 100)
}
