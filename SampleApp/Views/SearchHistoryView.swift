//
//  SearchHistoryView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI
import SwiftData

struct SearchHistoryView: View {
    @Query(sort: [.init(\WordEntry.lastUpdated, order: .reverse)]) var entries: [WordEntry]
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismissSearch) private var dismissSearch

    var viewModel: RootViewModel
    
    var body: some View {
            ForEach(entries) { entry in
                Button(entry.word) {
                    dismissSearch()
                    viewModel.search(entry)
                }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let entry = entries[index]
                    modelContext.delete(entry)
                    try? modelContext.save()
                }
            }
    }
}
