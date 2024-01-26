//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct WordResponse: Codable {
    let meta: Meta?
    let shortdef: [String]?
    let hwi: HeadwordInfo?
    let fl: String?
    let suggestions: [String]?
    
    // helper in it for suggestion handling
    init(suggestions: [String]) {
        self.meta = nil
        self.shortdef = nil
        self.hwi = nil
        self.fl = nil
        self.suggestions = suggestions
    }
    
    var word: Word {
        return Word(text: meta!.stems.first!, definitions: shortdef!, homewordInfo: hwi!, functionalLabel: fl!)
    }
    
    static func parseData(_ data: Data) -> WordResponse? {
        do {
            let response = try JSONDecoder().decode([WordResponse].self, from: data)
            // returns on the first type of word that matches, likely to be the most common. Expand from here to allow mulitipe POS per section
            return response.first
        } catch {
            // if thre was a decode error, then likely there was no word found, so try to decode for suggestions (this masks decoding errors above, comment this out to catch real errors from above)
            do {
                let suggestions = try JSONDecoder().decode([String].self, from: data)
                return WordResponse(suggestions: suggestions)
            } catch {
                // error everythign else
                print("WORD RESPONSE ERROR: ", error)
            }
        }
        return nil
    }
}
