//
//  ViewModel.swift
//  SampleApp
//
//  Created by Fabriccio De la Mora on 15/12/22.
//

import Foundation
import SwiftUI

struct ErrorMessage: Identifiable {
    var id: String { message }
    let message: String
}

class DefinitionSearchViewModel {
    func fetchDefinition(_ text: String,
                         thesaurus: Bool,
                         completion: @escaping (([String]) -> Void),
                         failure: @escaping ((String) -> Void)) {
        
        API.shared.fetchWord(query: text, thesaurus: thesaurus) { response in
            switch response {
            case .success(let data):
                completion(WordResponse.parseData(data))
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
