    //
    //  Constants.swift
    //  SampleApp
    //
    //  Created by Nic on 8/9/24.
    //

import Foundation

struct Constants {
    
    struct Errors {
        
        static func enterWordToSearch() -> String {
            return "Enter a word to search."
        }
        
        static func noResultsFound(for word: String) -> String {
            return "No results found for '\(word)'. Please try another word."
        }
        
        static func decodingFailed(for word: String) -> String {
            return "Failed to decode the response for '\(word)'. Please try another word."
        }
    }
}
