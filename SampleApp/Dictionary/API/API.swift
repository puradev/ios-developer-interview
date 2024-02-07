//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

class API {
    
    static func lookup(word: String, type: APIEndpoint.LookupType) async throws -> Data {
        guard !word.isEmpty else {
            throw APIError.emptyQuery
        }
        
        guard word.count > 2 else {
            throw APIError.tooShort(word)
        }
        
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.lookup(word: word, type: type))
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw APIError.badStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}
