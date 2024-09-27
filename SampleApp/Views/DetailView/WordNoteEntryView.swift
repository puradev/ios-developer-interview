//
//  WordNoteEntryView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/27/24.
//

import SwiftUI
import SwiftData

struct WordNoteEntryView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var currentNote: String
    @Binding var navigationStack: [Destination]
    let entry: WordEntry
    
    init(entry: WordEntry, navigationStack: Binding<[Destination]>) {
        self.entry = entry
        self.currentNote = entry.personalNote
        self._navigationStack = navigationStack
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("What are examples of what \(entry.word) is?")
            TextEditor(text: $currentNote)
                .border(.black, width: 2)
        }
        .padding()
        .navigationTitle(entry.word)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                // TODO: If the currentNote differs from entry.note, show an alert.
                Button("Cancel") {
                    navigationStack = []
                }
            }
            // TODO: Disable toolbar item if nothing has changed
            ToolbarItem(placement: .primaryAction) {
                Button("Save") {
                    entry.personalNote = currentNote
                    try? modelContext.save()
                    navigationStack = []
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        WordNoteEntryView(entry: .init(word: "Happiness", wordResponse: .init(meta: .init(id: "Hapineess", uuid: "123", sort: "", stems: [""], offensive: false), shortdef: ["Happiness is a complex and multifaceted emotion that encompasses a range of positive feelings, from contentment to intense joy. It is often associated with positive life experiences, such as achieving goals, spending time with loved ones, or engaging in enjoyable activities. However, happiness can also arise spontaneously, without any apparent external cause."]), context: nil), navigationStack: .constant([]))
    }
}
