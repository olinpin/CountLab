//
//  ContentView.swift
//  CountLab
//
//  Created by Oliver Hnát on 17.08.2024.
//

import SwiftUI
import CoreData

struct CounterListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var counters: FetchedResults<Counter>
    
    @State var addCounter = false

    var body: some View {
        NavigationView {
            List {
                ForEach(counters) { counter in
                    NavigationLink {
                        CounterView(counter: counter)
                            .navigationTitle(counter.name ?? "")
                    } label: {
                        CounterListItemView(counter: counter)
                            .frame(height: 100)
                    }
                }
                .onDelete(perform: deleteCounter)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {self.addCounter = true}) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            Text("Select an item")
        }
        .sheet(isPresented: $addCounter, content: {
            NavigationStack {
                AddCounter(visible: $addCounter)
                    .navigationTitle("Add Counter")
            }
        })
    }
    
    
    private func deleteCounter(offsets: IndexSet) {
        withAnimation {
            offsets.map { counters[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    CounterListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
