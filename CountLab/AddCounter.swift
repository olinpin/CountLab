//
//  AddCounter.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI
import EmojiPicker

struct AddCounter: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var visible: Bool
    @State var backgroundColor: Color = .random().opacity(0.25)
    @State var name: String = ""
    
    @State var goal: Float = 10
    @State var stringGoal: String = ""
    
    @State var showError = false
    @State private var errorMessage: String?
    
    @State private var color: Color = .primary
    @State private var displayEmojiPicker: Bool = false
    @State private var emoji: Emoji = DefaultEmojiProvider().getAll().randomElement()!

    var body: some View {
        Form {
            Section {
                EmojiCircle(emoji: self.emoji.value, backgroundColor: self.backgroundColor)
                    .padding()
            }
            Section {
                ColorPicker("Background color", selection: $backgroundColor)
                Button(action: {
                    self.displayEmojiPicker = true
                }, label: {
                    HStack {
                        Text("Emoji: ")
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(self.emoji.value)")
                        // TODO: fix the alignment of the emoji and color picker
                    }
                })
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
                    self.addCounter()
                }
            }, label: {
                Text("Submit")
            })
        }
        .alert(isPresented: $showError) {
            Alert(title: Text("\(errorMessage ?? "No errors")"))
        }
        .sheet(isPresented: $displayEmojiPicker) {
            NavigationView {
                EmojiPickerView(selectedEmoji: Binding($emoji))
                    .navigationTitle("Emojis")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    self.visible = false
                }, label: {
                    Text("Cancel")
                        .foregroundStyle(.red)
                })
            })
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
            counter.emoji = self.emoji.value
            counter.goal = self.goal
            counter.id = UUID()
            
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
