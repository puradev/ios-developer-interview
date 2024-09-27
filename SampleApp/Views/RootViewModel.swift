//
//  RootViewModel.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/27/24.
//

import SwiftUI
import SwiftData

@Observable
class RootViewModel {
    var navigationStack: [Destination] = [] {
        didSet {
            if navigationStack.isEmpty {
                searchString = ""
                currentEntry = nil
            }
        }
    }
    var searchString: String = ""
    var currentEntry: WordEntry?
    var isLoading = false
    private var currentTask: Task<Void, Never>?
    private var api: API
    var context: ModelContext?
    
    init(navigationStack: [Destination] = [], api: API = API.shared) {
        self.api = api
        self.navigationStack = navigationStack
    }
    
    @MainActor
    func search(_ wordEntry: WordEntry? = nil) {
        currentTask?.cancel()
        currentTask = nil
        isLoading = false
        
        if let wordEntry {
            searchString = wordEntry.word
            currentEntry = wordEntry
            navigationStack = [.detailView(wordEntry)]
        } else {
            makeSearchAPICall()
        }
    }
    
    private func makeSearchAPICall() {
        isLoading = true
        currentTask = Task {
            do {
                let response = try await api.fetchWord(query: searchString)
                guard !Task.isCancelled else { return } // don't update isLoading
                let entry = WordEntry(word: searchString, definition: response.definition, synonyms: response.synonyms, context: context)
                self.currentEntry = entry
                navigationStack = [.detailView(entry)]
                isLoading = false
            } catch {
                isLoading = false
                print("🔥 API ERROR: \(String(describing: error))")
            }
        }
    }
}
