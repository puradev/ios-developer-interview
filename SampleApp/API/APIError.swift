//
//  APIError.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


enum APIError: String, Error {
    case badURL = "Something went wrong with the URL. Please try again later."
    case custom = "Sorry, we were unable to recognize this word. Please try a different one."
    case noData = "No data received back from the server"
    case emptyQuery = "Please type a word before searching"
    case tooShort = "The word you type was too short. Please try again"
    case responseError = "Something went wrong with our service. Please try again."
    case requestFailed = "Something went wrong with the request. Please try again."
}
