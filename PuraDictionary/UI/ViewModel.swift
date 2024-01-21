//
//  MainViewModel.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var showWord = false

    var wordResponse: WordResponse?
    
    func performSearch() {
        API.shared.fetchWord(query: searchText) { response in
            switch response {
            case .success(let data):
                
                if let str = String(data: data, encoding: .utf8) {
                    print(str)
                }
                
                guard let r = WordResponse.parseData(data) else {
                    // show Error
                    return
                }
                print(r)
                
                
                self.wordResponse = r
                
                DispatchQueue.main.async {
                    self.showWord = true
                }
                
            case .failure(let error):
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
    }
}
