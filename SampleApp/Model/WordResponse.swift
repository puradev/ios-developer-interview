//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct HeadwordInfo: Codable {
    let hw: String
}

struct WordResponse: Codable {
    let meta: Meta
    let shortdef: [String]
    let hwi: HeadwordInfo
    let fl: String
    
    var word: Word {
        return Word(id: meta.id, text: hwi.hw, definitions: shortdef, functionalLabel: fl)
    }
    
    static func word(from data: Data) throws -> [WordResponse]? {
        guard let firstWordDefinition = try JSONDecoder().decode([WordResponse].self, from: data).first else {
            return nil
        }
        
        //keep it as an array because you could easily modify this to return an array of definitions for a word
        return [firstWordDefinition]
    }
}
