//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct WordResponse: Codable {
    
    let meta: Meta
    let shortdef: [String]
    let fl: String
    
    var word: Word {
        var allRelatedWords = meta.stems
        allRelatedWords.removeFirst()
        var altWordVersions = allRelatedWords
        let originalWord = meta.stems.first ?? ""
        
        return Word(searchedWord: originalWord, altWords: altWordVersions, definitions: shortdef, wordType: fl)
    }
    
    static func parseData(_ data: Data) -> WordResponse? {
        do {
            let response = try JSONDecoder().decode([WordResponse].self, from: data)
            return response.first
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }
}
