//
//  ThesaurusScreenViewModel.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI
import Combine


class ThesaurusScreenViewModel: ObservableObject {
    
    @Published var thesaurus: [ThesaurusResponse] =  []
    @Published var error: APIError?
    
    private var cancellables = Set<AnyCancellable>()
//    private let networking = Networking()
    
    func fetchThesaurus(query: String) {
        API.shared.fetchThesaurus(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Thesaurus SUCCESS")
                case .failure(let error):
                    print("Thesaurus ERROR \(error.rawValue)")
                    self.error = error
                }
            }, receiveValue: { thesaurus in
                self.thesaurus = thesaurus
            })
            .store(in: &cancellables)
    }

    
}
