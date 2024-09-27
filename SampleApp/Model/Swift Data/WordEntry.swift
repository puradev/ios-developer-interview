//
//  WordEntry.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import Foundation
import SwiftData

@Model
class WordEntry: Identifiable {
    private var wordResponse: WordResponse
    private var synonymsResponse: SynonymsResponse
    @Attribute(.unique) var word: String
    var definitions: [String] { wordResponse.shortdef }
    var synonyms: [String] { synonymsResponse.synonyms.flatMap({ $0 }) }
    var antonyms: [String] { synonymsResponse.antonyms.flatMap({ $0 }) }
    var personalNote: String
    var lastUpdated: Date
    var id: String { word }
    
    init(word: String, definition: WordResponse, synonyms: SynonymsResponse, context: ModelContext?) {
        self.word = word
        wordResponse = definition
        synonymsResponse = synonyms
        lastUpdated = .now
        personalNote = ""
        context?.insert(self)
        try? context?.save()
    }
}
