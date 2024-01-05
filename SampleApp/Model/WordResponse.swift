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

    var word: Word {
        return Word(text: meta.stems.first!, definitions: shortdef)
    }

    static func words(from data: Data) -> [WordResponse]? {
        do {
            let response = try JSONDecoder().decode([WordResponse].self, from: data)
            return response
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }

    static func word(from data: Data) -> WordResponse? {
      words(from: data)?.first
    }
}
