//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

public enum APIError: Error {
    case badURL
    case custom(String)
    case noData
    case badData
    case emptyQuery
    case tooShort(String)
}
