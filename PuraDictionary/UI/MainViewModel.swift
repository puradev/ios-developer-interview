//
//  MainViewModel.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var searchText = ""
    
    @Published var showWord = false
    @Published var showInvalidWordError = false
    
    @Published var showAPIError = false
    @Published var apiErrorText = ""
    
    var wordResponse: WordResponse?
    
    func fetchWordFromDictionary() {
        API.shared.fetchWord(query: searchText) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    DispatchQueue.main.async {
                        self.showInvalidWordError = true
                    }
                    return
                }
                
                self.wordResponse = r
                print(r)
                
                DispatchQueue.main.async {
                    self.showWord = true
                    self.searchText = ""
                }
                
            case .failure(let error):
                var errorText = ""
                switch error {
                case .badURL:
                    errorText = "Bad URL"
                case .emptyQuery:
                    errorText = "Empty Query"
                case .noData:
                    errorText = "No Data"
                case .tooShort(let query):
                    errorText = "Word must be more than 2 characters: " + query
                case .custom(let description):
                    errorText = description
                }
                
                DispatchQueue.main.async {
                    self.apiErrorText = errorText
                    self.showAPIError = true
                }
            }
        }
    }
}
