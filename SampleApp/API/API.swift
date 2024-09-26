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
    
    static let baseUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    
    func fetchWord(query: String) async throws -> WordResponse {
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
        
        let request = URLRequest(url: url)
        
        print("Fetching from: ", request.url?.absoluteString ?? "")
        do {
            let (data, _) = try await session.data(for: request)
            do {
                guard let response = try WordResponse.parseData(data).first else {
                    throw APIError.noData
                }
                return response
            } catch {
                print("WORD RESPONSE ERROR: ", error)
                throw APIError.custom(String(describing: error))
            }
        } catch {
            throw APIError.custom(String(describing: error))
        }
    }
    
}
