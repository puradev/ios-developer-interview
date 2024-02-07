//
//  WebsterDictionary.swift
//  SampleApp
//
//  Created by Kody Holman on 2/6/24.
//

import Foundation

enum WebsterDictionaryError: Error, LocalizedError {
    case parseError
    case defineError(word: String, message: String)
    
    var errorDescription: String? {
        switch self {
        case .parseError:
            "Unable to read data from server."
        case .defineError(let word, let errorMessage):
            "Unable to define '\(word)' because of error: \(errorMessage)"
        }
    }
}

struct WebsterDictionary {
    
    static func lookup(word: String) async throws -> Word {
        
        let wordResponses: [WordResponse]
        
        do {
            let data = try await API.lookup(word: word, type: .dictionary)
            wordResponses = try JSONDecoder().decode([WordResponse].self, from: data)
        } catch is DecodingError {
            throw WebsterDictionaryError.parseError
        } catch {
            throw WebsterDictionaryError.defineError(word: word, message: error.localizedDescription)
        }
        
        guard let word = wordResponses.first?.word else {
            throw WebsterDictionaryError.parseError
        }
        
        return word
    }
}
