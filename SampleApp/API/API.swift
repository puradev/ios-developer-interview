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

    enum RequestKind {
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

    func fetchWord(query: String, requestKind: RequestKind, _ completion: @escaping (Result<Data, APIError>) -> Void) {
        guard !query.isEmpty else {
            completion(.failure(.emptyQuery))
            return
        }
        
        guard query.count > 2 else {
            completion(.failure(.tooShort(query: query)))
            return
        }

        let requestURL = URLBuilder(baseURL: requestKind.baseURL, word: query.lowercased(), token: requestKind.token).requestURL

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
