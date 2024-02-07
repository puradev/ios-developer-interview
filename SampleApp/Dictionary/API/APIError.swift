//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

enum APIError: Error, LocalizedError {
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort(String)
    case badStatusCode(Int)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            "Bad URL"
        case .custom(let message):
            "API Error (\(message))"
        case .noData:
            "No Data"
        case .emptyQuery:
            "Empty query"
        case .tooShort(_):
            "Too Short"
        case .badStatusCode(let statusCode):
            "Bad Status Code (\(statusCode))"
        }
    }
}
