//
//  RootView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI
import SwiftData

@Observable
class RootViewModel {
    var searchString: String = ""
    var currentEntry: WordEntry?
    var isLoading = false
    private var currentTask: Task<Void, Never>?
    private var api: API
    var context: ModelContext?
    
    init(api: API = API.shared) { // injectable
        self.api = api
    }
    
    @MainActor
    func search(_ wordEntry: WordEntry? = nil) {
        currentTask?.cancel()
        currentTask = nil
        isLoading = false
        
        if let wordEntry {
            searchString = wordEntry.word
            currentEntry = wordEntry
        } else {
            makeSearchAPICall()
        }
    }
    
    private func makeSearchAPICall() {
        isLoading = true
        currentTask = Task {
            do {
                let searchResult = try await api.fetchWord(query: searchString)
                guard !Task.isCancelled else { return } // don't update isLoading
                self.currentEntry = .init(word: searchString, wordResponse: searchResult, context: context) // should save automatically
                
                isLoading = false
            } catch {
                isLoading = false
                print("🔥 API ERROR: \(String(describing: error))")
            }
        }
    }
}

struct RootView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @State var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            if let entry = viewModel.currentEntry {
                WordDetailView(entry: entry)
            } else if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .font(.largeTitle)
            } else {
                SearchHistoryView(viewModel: viewModel)
            }
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
