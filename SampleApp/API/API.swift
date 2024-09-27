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
    
    func fetchWord(query: String) async throws -> (definition: WordResponse, synonyms: SynonymsResponse) {
        guard !query.isEmpty else {
            throw APIError.emptyQuery
        }
        
        guard query.count > 2 else {
            throw APIError.tooShort(query)
        }
        let query = query.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let definition = try await fetchWordDefinition(query)
        let synonyms = try await fetchWordSynonyms(query)
        return (definition, synonyms)
    }
    
    func fetchWordSynonyms(_ query: String) async throws -> SynonymsResponse {
        let requestURL = URL(string: "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/\(query)?key=\(Tokens.apiKeyThes)")!
        return try await fetchFirst(at: requestURL)
        
    }
    
    private func fetchWordDefinition(_ query: String) async throws -> WordResponse {
        let requestURL = URL(string: "https://www.dictionaryapi.com/api/v3/references/collegiate/json/\(query)?key=\(Tokens.apiKeyDict)")!

        return try await fetchFirst(at: requestURL)
    }
    
    private func fetchFirst<T: Codable>(at url: URL) async throws -> T {
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
