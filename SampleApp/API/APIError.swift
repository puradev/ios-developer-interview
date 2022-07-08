//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


enum APIError: Error, Equatable {
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort
}
