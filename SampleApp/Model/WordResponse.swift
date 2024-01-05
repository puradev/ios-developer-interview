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
    let hwi: HeadwordInfo
    let fl: String

    struct HeadwordInfo: Codable {
        let hw: String
    }

    var word: Word {
        return Word(id: meta.id, text: hwi.hw, definitions: shortdef, functionalLabel: fl)
    }

    static func words(from data: Data) throws -> [WordResponse]? {
        let response = try JSONDecoder().decode([WordResponse].self, from: data)
        return response
    }

    static func word(from data: Data) throws -> WordResponse? {
        try words(from: data)?.first
    }
}
