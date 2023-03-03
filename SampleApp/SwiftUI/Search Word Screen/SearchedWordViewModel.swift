//
//  SearchedWordViewModel.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI
import Combine


class SearchedWordViewModel: ObservableObject {

    @Published var words: [WordResponse] =  []
    @Published var error: APIError?
    @Published var isAlertShowing: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
//    private let networking = Networking()
    
    
    func fetchWord(query: String) {
        API.shared.fetchWord(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("SUCCESS")
                case .failure(let error):
                    print("ERROR \(error.localizedDescription)")
                    self.error = error
                    self.words = []
                    self.isAlertShowing = true
                }
            }, receiveValue: { words in
                self.words = words
                self.isAlertShowing = false
            })
            .store(in: &cancellables)
    }
    
}
