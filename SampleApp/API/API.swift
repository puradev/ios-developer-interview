//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

public enum APIRoute {
    case getDefinition(String)
    case getSynonyms(String)

    private var baseURL: String {
        switch self {
        case .getDefinition:
            return "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"
        case .getSynonyms:
            return "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"
        }
    }

    var url: String {
        switch self {
        case let .getDefinition(query):
            return baseURL + query + "?key=" + Tokens.apiKeyDict

        case let .getSynonyms(query):
            return baseURL + query + "?key=" + Tokens.apiKeyThes
        }
    }

    var query: String {
        switch self {
        case let .getDefinition(query):
            return query

        case let .getSynonyms(query):
            return query
        }
    }

    func validateQuery() throws {
        guard !query.isEmpty else {
            throw APIError.emptyQuery
        }

        guard query.count > 2 else {
            throw APIError.tooShort(query)
        }
    }
}

class API: NSObject {
    static let shared = API()
    let session = URLSession.shared

    func fetch<T: Codable>(route: APIRoute) async throws -> T {
        try route.validateQuery()

        guard let url = URL(string: route.url) else {
            throw APIError.badURL
        }

        #if DEBUG
        print("HTTP Request in flight for \(route.url)")
        #endif

        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        #if DEBUG
        print("HTTP Response for \(route.url)")
        // This log can be pretty verbose, todo would be to make it a flag at buildtime?
        print(data.prettyPrintedJSONString ?? "")
        #endif
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
}
