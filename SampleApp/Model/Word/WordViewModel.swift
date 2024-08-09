    //
    //  WordViewModel.swift
    //  SampleApp
    //
    //  Created by Nic on 8/9/24.
    //

import SwiftUI
import Combine

class WordViewModel: ObservableObject {
    
    @Published var results: [String] = []
    
    private var dictionaryCache: [String: [String]] = [:]
    private var thesaurusCache: [String: [String]] = [:]
    private var cancellables = Set<AnyCancellable>()
    
    func fetchWordData(for word: String, service: API.Service) {
        guard !word.trimmingCharacters(in: .whitespaces).isEmpty else {
            DispatchQueue.main.async {
                self.results = [Constants.Errors.enterWordToSearch()]
            }
            return
        }
        
        if let cachedResults = cachedResults(for: word, service: service) {
            results = cachedResults
            return
        }
        
        API.shared.fetchWord(query: word, service: service) { [weak self] result in
            switch result {
                case .success(let data):
                    self?.handleSuccess(data: data, word: word, service: service)
                case .failure(let error):
                    print("Error fetching word data: \(error.localizedDescription)")
                    self?.results = [Constants.Errors.decodingFailed(for: word)]
            }
        }
    }
    
    private func cachedResults(for word: String, service: API.Service) -> [String]? {
        switch service {
            case .dictionary:
                return dictionaryCache[word]
            case .thesaurus:
                return thesaurusCache[word]
        }
    }
    
    private func handleSuccess(data: Data, word: String, service: API.Service) {
        switch service {
            case .dictionary:
                decodeDictionaryResponse(data, word: word)
            case .thesaurus:
                decodeThesaurusResponse(data, word: word)
        }
    }
    
    private func decodeDictionaryResponse(_ data: Data, word: String) {
        do {
            let dictionaryResponse = try JSONDecoder().decode([DictionaryResponse].self, from: data)
            let definitions = dictionaryResponse.flatMap { $0.shortdef }
            
            DispatchQueue.main.async {
                if definitions.isEmpty {
                    self.results = [Constants.Errors.noResultsFound(for: word)]
                } else {
                    self.results = definitions
                    self.dictionaryCache[word] = definitions
                }
            }
        } catch {
            print("Failed to decode dictionary response: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.results = [Constants.Errors.decodingFailed(for: word)]
            }
        }
    }
    
    private func decodeThesaurusResponse(_ data: Data, word: String) {
        do {
            let thesaurusResponse = try JSONDecoder().decode([ThesaurusResponse].self, from: data)
            let synonyms = thesaurusResponse.flatMap { $0.meta.syns.flatMap { $0 } }
            
            DispatchQueue.main.async {
                if synonyms.isEmpty {
                    self.results = [Constants.Errors.noResultsFound(for: word)]
                } else {
                    self.results = synonyms
                    self.thesaurusCache[word] = synonyms
                }
            }
        } catch {
            print("Failed to decode thesaurus response: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.results = [Constants.Errors.decodingFailed(for: word)]
            }
        }
    }
}

extension WordViewModel {
    
    func testableHandleSuccess(data: Data, word: String, service: API.Service) {
        self.handleSuccess(data: data, word: word, service: service)
    }
    
    var testableCancellables: Set<AnyCancellable> {
        get { return self.cancellables }
        set { self.cancellables = newValue }
    }
}
