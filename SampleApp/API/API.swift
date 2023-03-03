//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation
import Combine

class API: NSObject {
    static let shared = API()
    static let collegiateBaseURL = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
    static let thesaurusBaseURL = "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
    
    func fetchWord(query: String) -> AnyPublisher<[WordResponse], APIError> {
    
        let requestURL = URLBuilder(baseURL: API.collegiateBaseURL, word: query.lowercased(), token: Tokens.apiKeyDict).requestURL
        
        guard let url = URL(string: requestURL) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        guard !query.isEmpty else {
            return Fail(error: APIError.emptyQuery).eraseToAnyPublisher()

        }
        
        guard query.count > 2 else {
            return Fail(error: APIError.tooShort).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                return APIError.requestFailed
            }
            .flatMap(maxPublishers: .max(1)) { data, response -> AnyPublisher<[WordResponse], APIError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return Fail(error: APIError.responseError).eraseToAnyPublisher()
                }
                
                let decoder = JSONDecoder()
                guard let words = try? decoder.decode([WordResponse].self, from: data) else {
                    return Fail(error: APIError.custom).eraseToAnyPublisher()
                }
                
                return Just(words)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
    func fetchThesaurus(query: String) -> AnyPublisher<[ThesaurusResponse], APIError> {
    
        let requestURL = URLBuilder(baseURL: API.thesaurusBaseURL, word: query.lowercased(), token: Tokens.apiKeyThes).requestURL
        
        guard let url = URL(string: requestURL) else {
            return Fail(error: APIError.badURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error in
                return APIError.requestFailed
            }
            .flatMap(maxPublishers: .max(1)) { data, response -> AnyPublisher<[ThesaurusResponse], APIError> in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    return Fail(error: APIError.responseError).eraseToAnyPublisher()
                }
                
                let decoder = JSONDecoder()
                guard let thesaurus = try? decoder.decode([ThesaurusResponse].self, from: data) else {
                    return Fail(error: APIError.custom).eraseToAnyPublisher()
                }
                
                return Just(thesaurus)
                    .setFailureType(to: APIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
}
