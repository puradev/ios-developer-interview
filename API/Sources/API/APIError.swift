//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

public enum APIError: Error, Equatable {
    case badURL
    case custom(String)
    case noData
    case emptyQuery
    case tooShort(String)

  var localizedDescription: String {
    switch self {
    case .badURL:
      return "Bad URL request. Check your query and try again."
    case .custom(let string):
      return string
    case .noData:
      return "No data was returned. Try again."
    case .emptyQuery:
      return "Your query was empty. Enter a word and try again."
    case .tooShort(_):
      return "Your query was too short. Try again."
    }
  }
}
