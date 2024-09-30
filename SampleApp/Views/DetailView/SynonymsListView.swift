//
//  SynonymsListView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/27/24.
//

import SwiftUI

struct SynonymsListView: View {
    @Binding var navigationStack: [Destination]
    let entry: WordEntry

    var body: some View {
        List {
            Section("Synonyms") {
                ForEach(entry.synonyms, id: \.self) { synonymSet in
                    Text(synonymSet.joined(separator: ", "))
                }
            }
            Section("Antonyms") {
                ForEach(entry.antonyms, id: \.self) { antonymSet in
                    Text(antonymSet.joined(separator: ", "))
                        .multilineTextAlignment(.trailing)
                }
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
}

#Preview {
    RootView(viewModel: .init(navigationStack: [
        .detailView(.Previews.happy),
        .detailViewImages(.Previews.happy),
        .detailViewSynonyms(.Previews.happy)
    ]))
}
