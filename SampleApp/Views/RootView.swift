//
//  RootView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI
import SwiftData

enum Destination: Hashable {
    case detailView(WordEntry)
    case detailViewImages(WordEntry)
    case detailViewSynonyms(WordEntry)
    case detailViewNote(WordEntry)
}

struct RootView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationStack) {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .font(.largeTitle)
                } else {
                    List {
                        SearchHistoryView(viewModel: viewModel)
                    }
                }
            }
            .navigationDestination(for: Destination.self, destination: { destination in
                switch destination {
                case .detailView(let wordEntry):
                    WordDetailView(entry: wordEntry, navigationStack: $viewModel.navigationStack)
                case .detailViewImages(let wordEntry):
                    WordImagesView(navigationStack: $viewModel.navigationStack, entry: wordEntry)
                case .detailViewSynonyms(let wordEntry):
                    SynonymsListView(navigationStack: $viewModel.navigationStack, entry: wordEntry)
                case .detailViewNote(let wordEntry):
                    WordNoteEntryView(entry: wordEntry, navigationStack: $viewModel.navigationStack)
                }
            })
        }
        .searchable(text: $viewModel.searchString, prompt: "Define <genius>")
        .onSubmit(of: .search) {
            viewModel.search()
        }
        .onAppear {
            viewModel.context = modelContext
        }
    }
}

#Preview {
    RootView()
}
