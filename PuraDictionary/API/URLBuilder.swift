//
//  URLBuilder.swift
//  PuraDictionary
//
//  Created by natehancock on 6/28/22.
//

import Foundation

enum QueryType {
    case dictionary
    case thesaurus
    
    var baseURL: String {
        switch self {
        case .dictionary:
            return "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
            
        case .thesaurus:
            return "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
        }
    }
    
    var token: String {
        switch self {
        case .dictionary:
            return Tokens.apiKeyDict
        case .thesaurus:
            return Tokens.apiKeyThes
        }
    }
}

struct URLBuilder {
    var type: QueryType
    var word: String

    var requestURL: String {
        let url = type.baseURL + word + "?key=" + type.token
        return url
    }
}
