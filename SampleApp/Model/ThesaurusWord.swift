//
//  ThesaurusWord.swift
//  SampleApp
//
//  Created by Sean Machen on 12/4/23.
//

import Foundation

struct ThesaurusWord: Codable, Equatable {
    private let synonyms: [String]
    private let antonyms: [String]

    var synonymDescription: String {
        if synonyms.isEmpty {
            return "This word has no synonyms."
        } else {
            return synonyms.joined(separator: ", ")
        }
    }

    var antonymDescription: String {
        if antonyms.isEmpty {
            return "This word has no antonyms."
        } else {
            return antonyms.joined(separator: ", ")
        }
    }

    init(synonyms: [String], antonyms: [String]) {
        self.synonyms = synonyms
        self.antonyms = antonyms
    }
}
