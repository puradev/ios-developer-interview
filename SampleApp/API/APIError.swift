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
    case parsingIssue
    case emptyQuery
    case tooShort(query: String)
}
