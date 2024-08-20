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
    
    @State var numberField: Float?
    
    var body: some View {
        VStack {
            StrokeEmojiCircle(counter: counter)
                .padding(.bottom)
            
            Text("Total: \(Utils.formatFloat(self.done))/\(Utils.formatFloat(self.goal))")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding(.bottom)
            
            TextField("Enter Value", value: $numberField, formatter: Formatter.withSeparator)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue, lineWidth: 2)
                    }
                    .padding()
            HStack(spacing: 20) {
                makeButton(text: "Subtract", action: {}, color: .red)
                makeButton(text: "Add", action: {}, color: .blue)
            }
            .padding(.top)
        }
        .padding()
    }
    
    func makeButton(text: String, action: @escaping () -> (), color: Color) -> some View {
        Button(action: action, label: {
            Text(text)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .padding()
                .background(color)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
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
