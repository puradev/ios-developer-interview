//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

class API: NSObject {
    static let shared = API()
    let session = URLSession.shared
    
    static let baseDefinitionUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    static let baseThesaurusUrl = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
    
    func fetchWord(query: String) async throws -> (definition: WordResponse, synonyms: SynonymsResponse) {
        guard !query.isEmpty else {
            throw APIError.emptyQuery
        }
        
        guard query.count > 2 else {
            throw APIError.tooShort(query)
        }
        
        let definition = try await fetchWordDefinition(query)
        let synonyms = try await fetchWordSynonyms(query)
        return (definition, synonyms)
    }
    
    func fetchWordSynonyms(_ query: String) async throws -> SynonymsResponse {
        let requestURL = URLBuilder(baseURL: API.baseThesaurusUrl, word: query.lowercased(), auth: Tokens.apiKeyThes).requestURL
        return try await fetchFirst(at: requestURL)
        
    }
    
    private func fetchWordDefinition(_ query: String) async throws -> WordResponse {
        let requestURL = URLBuilder(baseURL: API.baseDefinitionUrl, word: query.lowercased(), auth: Tokens.apiKeyDict).requestURL
        return try await fetchFirst(at: requestURL)
    }
    
    private func fetchFirst<T: Codable>(at requestURL: String) async throws -> T {
        guard let url = URL(string: requestURL) else {
            throw APIError.badURL
        }
        print("Fetching from: ", url.absoluteString)
        do {
            let (data, _) = try await session.data(from: url)
            do {
                let values = try JSONDecoder().decode([T].self, from: data)
                guard let value = values.first else {
                    throw APIError.noData
                }
                return value
            } catch {
                print("🔥 DECODING ERROR: ", error)
                throw APIError.custom(String(describing: error))
            }
        } catch {
            throw APIError.custom(String(describing: error))
        }
    }
    
}
