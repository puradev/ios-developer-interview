//
//  URLBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct URLBuilder {
    var baseURL: String
    var word: String

    var sanitizedWord: String {
        // Trim spaces from start and end
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        // Keep only alpha characters and spaces
        let alphaAndSpaceOnlyWord = trimmedWord.filter { $0.isLetter || $0.isWhitespace }
        // Replace remaining spaces with "+"
        return trimmedWord.replacingOccurrences(of: " ", with: "+")
    }
    
    var requestDictionaryURL: String {
        let url = baseURL + sanitizedWord + "?key=" + Tokens.apiKeyDict
        return url
    }
    
    var requestThesaurusURL: String {
        let url = baseURL + sanitizedWord + "?key=" + Tokens.apiKeyThes
        return url
    }
}
