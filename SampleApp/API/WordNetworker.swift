//
//  WordNetworker.swift
//  SampleApp
//
//  Created by Sean Machen on 12/3/23.
//

import Foundation

protocol WordNetworking: AnyObject {
    func fetchDictionaryWord(forSearchText searchText: String, completion: @escaping (Result<DictionaryWordResponse, APIError>) -> Void)
    func fetchThesaurusWord(forSearchText searchText: String, completion: @escaping (Result<ThesaurusWordResponse, APIError>) -> Void)
}

final class WordNetworker: WordNetworking {
    private let api: API

    init(api: API) {
        self.api = api
    }

    func fetchDictionaryWord(forSearchText searchText: String, completion: @escaping (Result<DictionaryWordResponse, APIError>) -> Void) {
        api.fetchWord(query: searchText, requestKind: .dictionary) { response in
            switch response {
            case .success(let data):
                guard let wordResponce = DictionaryWordResponse.parseData(data) else {
                    completion(.failure(.parsingIssue))
                    return
                }
                completion(.success(wordResponce))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchThesaurusWord(forSearchText searchText: String, completion: @escaping (Result<ThesaurusWordResponse, APIError>) -> Void) {
        api.fetchWord(query: searchText, requestKind: .thesaurus) { response in
            switch response {
            case .success(let data):
                guard let wordResponce = ThesaurusWordResponse.parseData(data) else {
                    completion(.failure(.parsingIssue))
                    return
                }
                completion(.success(wordResponce))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

#if DEBUG
// MARK: - Mocks
final class MockWordNetworker: WordNetworking {
    func fetchDictionaryWord(forSearchText searchText: String, completion: (Result<DictionaryWordResponse, APIError>) -> Void) {
        completion(.success(.makeMock()))
    }

    func fetchThesaurusWord(forSearchText searchText: String, completion: @escaping (Result<ThesaurusWordResponse, APIError>) -> Void) {
        completion(.success(.makeMock()))
    }
}
#endif
