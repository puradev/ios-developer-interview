//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import Combine

class API: NSObject {
    
    let session = URLSession.shared
    static let shared = API()
    static let baseUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    
    func fetchWordOld(query: String, _ completion: @escaping (Result<Data, APIError>) -> Void) {
        guard !query.isEmpty else {
            completion(.failure(.emptyQuery))
            return
        }
        
        guard query.count > 2 else {
            completion(.failure(.tooShort(query)))
            return
        }
        
        let requestURL = URLBuilder(baseURL: API.baseUrl, word: query.lowercased()).requestURL
        
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
    
    func fetchWordNewUsingCombine(query: String) -> AnyPublisher<WordResponse, APIError> {
        
        return Future { [weak self] promise in
            
            guard !query.isEmpty else {
                promise(.failure(.emptyQuery))
                return
            }
            
            guard query.count > 2 else {
                promise(.failure(.tooShort(query)))
                return
            }
            
            let requestURL = URLBuilder(baseURL: API.baseUrl, word: query.lowercased()).requestURL
            
            guard let url = URL(string: requestURL) else {
                promise(.failure(.badURL))
                return
            }
            
            let request = URLRequest(url: url)
            
            print("Fetching from: ", request.url?.absoluteString ?? "")
            
            self?.session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    promise(.failure(.custom(error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    promise(.failure(.noData))
                    return
                }
                
                guard let response = WordResponse.parseData(data) else {
                    promise(.failure(.badData))
                    return
                }
                
                promise(.success(response))
                
            }.resume()
        }.eraseToAnyPublisher()
    }
}
