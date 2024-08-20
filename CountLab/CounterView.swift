//
//  CounterView.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI
import CoreData

struct CounterView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var counter: Counter
    
    var goal: Float = 10
    
    @State var floatLog: Float = 0
    
    @State var stringLog: String = ""
    
    @State var showAlert: Bool = false
    
    @State var errorMessage: String = ""
    
    @FocusState private var isTextFieldFocused: Bool
    
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        VStack {
            StrokeEmojiCircle(counter: counter)
                .padding(.bottom)
            
            Text("Total today: \(Utils.formatFloat(doneToday()))/\(Utils.formatFloat(self.goal))")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .padding(.bottom)
            
            TextField("Enter Value", text: $stringLog)
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
                .focused($isTextFieldFocused)
                .onChange(of: stringLog, initial: false) { oldValue, newValue in
                    if let value = Float(newValue) {
                        floatLog = value
                    } else if newValue == "" {
                        floatLog = 0
                    }
                }

            
            HStack(spacing: 20) {
                makeButton(text: "Subtract", action: subtractValue, color: .red)
                makeButton(text: "Add", action: addValue, color: .blue)
            }
            .padding(.top)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        .alert(isPresented: $showAlert , content: {
            Alert(title: Text("Error"), message: Text("\(errorMessage)"))
        })
        .onTapGesture {
            self.isTextFieldFocused = false
        }
    }
    
    private func addValue() {
        if self.floatLog != 0 {
            logValue(self.floatLog)
        }
        print("Adding \(self.floatLog)")
    }
    
    private func subtractValue() {
        if self.floatLog != 0 {
            logValue(-self.floatLog)
        }
    }

    private func logValue(_ value: Float) {
        print("self.numberField is not nill")
        let log = Log(context: viewContext)
        log.timestamp = Date()
        log.counter = counter
        log.value = value
        do {
            try viewContext.save()
            self.floatLog = 0
            self.stringLog = ""
            print("Saved")
        } catch {
            print("Something went wrong while saving")
            self.errorMessage = "Something went wrong while saving, please try again later"
            self.showAlert = true
        }
    }
    
    private func doneToday() -> Float {
        let sum: [Float] = counter.log?.map( {
            let log = $0 as! Log
            if log.timestamp != nil && log.timestamp!.isToday {
                return log.value
            }
            return 0
        }) ?? []
        return sum.reduce(0, +)
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    } catch {
    }
    return CounterView(counter: Counter(context: PersistenceController.preview.container.viewContext))
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
