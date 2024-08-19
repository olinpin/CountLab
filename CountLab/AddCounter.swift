//
//  AddCounter.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI

struct AddCounter: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var visible: Bool
    @State var backgroundColor: Color = .random().opacity(0.25)
    @State var name: String = ""
    @State var emoji: String = String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
    
    @State var goal: Float = 10
    @State var stringGoal: String = ""
    
    @State var showError = false
    
    @State private var errorMessage: String?
    
    @State private var color: Color = .primary
    
    // TODO: Add chooser for emojis and colors
    
    var body: some View {
        Form {
            Section {
                EmojiCircle(emoji: self.emoji, backgroundColor: self.backgroundColor)
                    .padding()
                
            }
            Section {
                ColorPicker("Background color", selection: $backgroundColor)
            }
            Section {
                TextField("Name", text: $name)
                TextField("Daily Goal", text: $stringGoal)
                    .keyboardType(.numberPad)
                    .onChange(of: stringGoal, initial: false) { oldValue, newValue in
                        if let value = Float(newValue) {
                            goal = value
                        }
                        self.color = .primary
                    }
                    .foregroundStyle(self.color)
            }
            Button (action: {
                self.validate()
                if !showError {
                    self.visible = false
                }
            }, label: {
                Text("Submit")
            })
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("\(errorMessage ?? "No errors")"))
        }
    }
    
    private func validate() {
        showError = Float(stringGoal) != goal || name == ""
        if showError {
            if name == "" {
                errorMessage = "Name cannot be empty"
            } else if Float(stringGoal) != goal {
                if stringGoal == "" {
                    errorMessage = "Daily goal cannot be empty"
                } else {
                    errorMessage = "Daily goal can only contain numbers"
                    self.color = .red
                }
            }
        }
    }
    
    private func addCounter() {
        withAnimation {
            let counter = Counter(context: viewContext)
            counter.backgroundColor = self.backgroundColor.hex
            counter.name = self.name
            counter.emoji = self.emoji
            counter.goal = self.goal
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    @State var visible = false
    return AddCounter(visible: $visible)
}
