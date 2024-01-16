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
    case tooShort(String)
    
    var localizedDescription: String {
      switch self {
      case .badURL:
        return "Malformed URL or Request structure"
      case .custom(let string):
        return string
      case .noData:
        return "Nothing Found."
      case .emptyQuery:
        return "Cannot search without a word"
      case .tooShort(_):
        return "Search word is not long enough. Please, try again with a longer word."
      }
    }
}
