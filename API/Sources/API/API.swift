//
//  API.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

public class API: NSObject {
    public static let shared = API()
    let session = URLSession.shared

    static let baseUrl = "https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

    public func fetchWord(query: String) async -> Result<Data, APIError> {
        guard !query.isEmpty else {
            return .failure(.emptyQuery)
        }

        guard query.count > 2 else {
            return .failure(.tooShort(query))
        }

        let requestURL = URLBuilder(baseURL: API.baseUrl, word: query.lowercased()).requestURL

        guard let url = URL(string: requestURL) else {
            return .failure(.badURL)
        }

        let request = URLRequest(url: url)

        print("Fetching from: ", request.url?.absoluteString ?? "")
      do {
        let data = try await session.data(for: request)
        return .success(data.0)
      } catch {
        return .failure(.custom(error.localizedDescription))
      }
    }

}
