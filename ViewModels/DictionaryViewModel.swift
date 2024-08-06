//
//  DictionaryViewModel.swift
//  LexiFindApp
//
//  Created by Joshua Brogdon on 8/6/24.
//

import Foundation
import Combine

public class DictionaryViewModel: ObservableObject {
    
    private var subscriptions = Set<AnyCancellable>()
    @Published var wordData: Word?
    @Published var noResultsText: String?
    
    func search(for word: String, didFinish: @escaping (Bool) -> Void) {
        API.shared.fetchWordNewUsingCombine(query: word)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Success!")
                    self?.noResultsText = nil
                    didFinish(false)
                    return
                case .failure(let error):
                    print("Error: ", error.localizedDescription)
                    self?.noResultsText = "No results found for \(word)"
                    didFinish(true)
                    return
                }
            }, receiveValue: { [weak self] response in
                self?.wordData = response.word
            }).store(in: &subscriptions)
    }
}
