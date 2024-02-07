//
//  APIEndpoint.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

enum APIEndpoint {
    
    static var baseURLString: String {
        get throws {
            guard let baseURLString = Bundle.main.infoDictionary?["API URL"] as? String else {
                throw APIError.badURL
            }
            return baseURLString
        }
    }
    
    enum LookupType {
        case dictionary
        case thesaurus
    }
    
    static func lookup(word: String, type: LookupType) throws -> URL {
        var urlString = try baseURLString + word
        switch type {
        case .dictionary:
            urlString += "?key=" + APITokens.apiKeyDict
        case .thesaurus:
            urlString += "?key=" + APITokens.apiKeyThes
        }
        
        guard let url = URL(string: urlString) else {
            throw APIError.badURL
        }
        
        return url
    }
}
