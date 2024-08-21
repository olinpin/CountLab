//
//  LogsView.swift
//  CountLab
//
//  Created by Oliver Hnát on 21.08.2024.
//

import SwiftUI

struct LogsView: View {
    @ObservedObject var counter: Counter
    var body: some View {
        if counter.log != nil {
            let backgroundColor = Color.init(hex:counter.backgroundColor ?? "#FFFFFF") ?? Color(UIColor.systemBackground)
            List(counter.log!.allObjects as! [Log]) { entry in
                HStack {
                    ZStack {
                        Circle()
                            .fill(backgroundColor)
                            .frame(width: 30, height: 30)
                        
                        Text("\(Utils.formatFloat(entry.value))")
                            .font(.headline)
                            .foregroundStyle(backgroundColor.appropriateTextColor())

                    }
                    Spacer()
                    if entry.timestamp != nil {
                        Text("\(entry.timestamp!.DDMMYYYY)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        Text("Date not available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                }
            }
        } else {
            Text("There are no entries for this counter")
        }
    }
}

#Preview {
    let request = Counter.fetchRequest()
    do {
        let counters = try PersistenceController.preview.container.viewContext.fetch(request)
        return LogsView(counter: counters.first!)
    } catch {}
        return LogsView(counter: Counter(context: PersistenceController.preview.container.viewContext))
}
