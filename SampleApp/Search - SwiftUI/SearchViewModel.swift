//
//  SearchViewModel.swift
//  SampleApp
//
//  Created by Drew Needham-Wood on 1/24/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var error: String?
    @Published var word: SwiftUIWord?
    
    enum SearchViewState {
        case empty
        case loading
        case loaded
        case error
    }
    
    @Published var viewState: SearchViewState = .empty
    
    func search(term: String) {        
        guard term != "" else {
            return
        }
        
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        
        API.shared.fetchWord(query: term) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    DispatchQueue.main.async {
                        self.error = "Could not parse data"
                        self.viewState = .error
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    self.word = SwiftUIWord(text: r.word.text,
                                            definitions: r.word.definitions.map({ Definition(string: $0)}))
                    self.viewState = .loaded
                }

            case .failure(let error):
                
                print("NETWORK ERROR: ", error.localizedDescription)
                DispatchQueue.main.async {
                    self.error = "NETWORK ERROR: \(error.localizedDescription)"
                    self.viewState = .error
                }
            }
        }
    }
}

struct SwiftUIWord: Identifiable {
    var id = UUID()
    var text: String
    var definitions: [Definition]
}

struct Definition: Identifiable {
    var id = UUID()
    var string: String
}
