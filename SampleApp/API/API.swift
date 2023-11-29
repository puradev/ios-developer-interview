//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

protocol WordFetchProvider {
    func fetch(word query: String) async throws -> [WordResponse]
}

class API: NSObject, WordFetchProvider {
    static let shared = API()
    let session = URLSession.shared
    
    static let baseUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

    func fetch(word query: String) async throws -> [WordResponse] {
        guard !query.isEmpty else {
            throw APIError.emptyQuery
        }

        guard query.count > 2 else {
            throw APIError.tooShort(query)
        }

        let requestURL = URLBuilder(baseURL: API.baseUrl, word: query.lowercased()).requestURL

        guard let url = URL(string: requestURL) else {
            throw APIError.badURL
        }

        #if DEBUG
        print("HTTP Request in flight for \(requestURL)")
        #endif

        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        #if DEBUG
        print("HTTP Response for \(requestURL)")
        // This log can be pretty verbose, todo would be to make it a flag at buildtime?
        print(data.prettyPrintedJSONString ?? "")
        #endif
        let result = try JSONDecoder().decode([WordResponse].self, from: data)
        return result
    }
}
