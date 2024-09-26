//
//  RootView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI

@Observable
class RootViewModel {
    var searchString: String = ""
    var searchResult: WordResponse?
    var isLoading = false
    var currentTask: Task<Void, Never>?
    private var api: API
    
    init(api: API = API.shared) { // injectable
        self.api = api
    }
    
    @MainActor
    func search() {
        isLoading = true
        currentTask = nil
        currentTask?.cancel()
        
        currentTask = Task {
            do {
                let searchResult = try await api.fetchWord(query: searchString)
                guard !Task.isCancelled else { return } // don't update isLoading
                self.searchResult = searchResult
                isLoading = false
            } catch {
                isLoading = false
                print("🔥 API ERROR: \(String(describing: error))")
            }
        }
    }
}

struct RootView: View {
    @State var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            if let searchResult = viewModel.searchResult {
                WordDetailView(response: searchResult)
            } else if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .font(.largeTitle)
            } else {
                // TODO: history view
                EmptyView()
            }
        }
        .searchable(text: $viewModel.searchString, prompt: "Define <genius>")
        .onSubmit(of: .search) {
            viewModel.search()
        }
    }
}

#Preview {
    RootView()
}
