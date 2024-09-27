//
//  WordDetailView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI

struct WordDetailView: View {
    let entry: WordEntry
    @Binding var navigationStack: [Destination]
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("WORD: " + entry.word)
                ForEach(entry.definitions, id: \.self) { definition in
                    Text("DEFINITION: " + definition)
                }
            }
            .navigationTitle(entry.word)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Next") {
                        navigationStack.append(.detailViewNote(entry))
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    WordDetailView(entry: .Previews.happy, navigationStack: .constant([]))
}
