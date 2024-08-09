    //
    //  API.swift
    //  SampleApp
    //
    //  Created by natehancock on 6/28/22.
    //

import Foundation

class API: NSObject {
    
    enum Service: String {
        case dictionary, thesaurus
    }
    
    static let shared = API()
    let session = URLSession.shared
    
    static let dictBaseUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    static let thesBaseUrl = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
    
    func fetchWord(query: String, service: Service, _ completion: @escaping (Result<Data, APIError>) -> Void) {
        guard !query.isEmpty else {
            completion(.failure(.emptyQuery))
            return
        }
        guard query.count > 2 else {
            completion(.failure(.tooShort(query)))
            return
        }
        let requestURL: String
        switch service {
            case .dictionary:
                requestURL = URLBuilder(baseURL: API.dictBaseUrl, word: query.lowercased()).dictRequestURL
            case .thesaurus:
                requestURL = URLBuilder(baseURL: API.thesBaseUrl, word: query.lowercased()).thesRequestURL
        }
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
