    //
    //  APIError.swift
    //  SampleApp
    //
    //  Created by natehancock on 6/28/22.
    //

import Foundation

enum APIError: Error {
    
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort(String)
    
    var localizedDescription: String {
        switch self {
            case .badURL:
                return "The URL is invalid."
            case .custom(let message):
                return message
            case .noData:
                return "No data received."
            case .emptyQuery:
                return "The query is empty."
            case .tooShort(let query):
                return "The query '\(query)' is too short."
        }
    }
}
