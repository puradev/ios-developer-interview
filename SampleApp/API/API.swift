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
    
    static let baseUrl = "https://www.dictionaryapi.com/api/v3/references/%@/json/"
    static let collegiatePath = "collegiate"
    static let thesaurusPath = "thesaurus"
    
    func fetchWord(query: String, thesaurus: Bool, _ completion: @escaping (Result<Data, APIError>) -> Void) {
        guard !query.isEmpty else {
            completion(.failure(.emptyQuery))
            return
        }
        
        guard query.count > 2 else {
            completion(.failure(.tooShort(query)))
            return
        }
        
        let requestURL = URLBuilder(baseURL: String(format: API.baseUrl, thesaurus ? API.thesaurusPath : API.collegiatePath), word: query.lowercased(), thesaurus: thesaurus).requestURL
        
        guard let url = URL(string: requestURL) else {
            completion(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        print("Fetching from: ", request.url?.absoluteString ?? "")
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
}
