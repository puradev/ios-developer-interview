//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import GiphyUISDK

class API: NSObject {
    static let shared = API()
    let session = URLSession.shared
    
    static let baseDictionaryURL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    static let baseThesaurusURL = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
    
    //updated to use async / await
    public func fetch(word: String) async -> Result<Data, APIError> {
        guard !word.isEmpty else {
            return .failure(.emptyQuery)
        }
        
        guard word.count > 2 else {
            return .failure(.tooShort(word))
        }
        
        let requestURL = URLBuilder(baseURL: API.baseDictionaryURL, word: word.lowercased()).requestDictionaryURL
        
        guard let url = URL(string: requestURL) else {
            return .failure(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        do {
            let data = try await session.data(for: request)
            return .success(data.0)
        } catch {
            return .failure(.custom(error.localizedDescription))
        }
    }
    
    // added thesaurus endpoint, just looking for synonyms to eventually feed into giphy request
    public func fetchSynonyms(for word: String) async -> Result<Data, APIError> {
        guard !word.isEmpty else {
            return .failure(.emptyQuery)
        }
        
        guard word.count > 2 else {
            return .failure(.tooShort(word))
        }
        
        let requestURL = URLBuilder(baseURL: API.baseThesaurusURL, word: word.lowercased()).requestThesaurusURL
        
        guard let url = URL(string: requestURL) else {
            return .failure(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await session.data(for: request)
            return .success(data)
        } catch {
            return .failure(.custom(error.localizedDescription))
        }
    }
    
    public func fetchMedia(for words: [String]) async -> Result<GPHMedia, APIError> {
        let searchTerm = words.joined(separator: " ")
        return await withCheckedContinuation { continuation in
            
            GPHCache.shared.clear()
            GiphyCore.shared.random(searchTerm, media: .gif, rating: .nsfw) { response, error in
                if let error = error {
                    print("Error searching GIFs: \(error)")
                    continuation.resume(returning: .failure(.custom("\(error)")))
                } else if let media = response?.data {
                    continuation.resume(returning: .success(media))
                } else {
                    print("No GIFs found for search term: \(searchTerm)")
                    continuation.resume(returning: .failure(.noData))
                }
            }
        }
    }
}
