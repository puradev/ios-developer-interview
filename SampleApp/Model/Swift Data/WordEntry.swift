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
    @Attribute(.unique) var word: String
    var definitions: [String] { wordResponse.shortdef }
    var personalNote: String
    var lastUpdated: Date
    var id: String { word }
    
    init(word: String, wordResponse: WordResponse, context: ModelContext?) {
        self.word = word
        self.wordResponse = wordResponse
        lastUpdated = .now
        personalNote = ""
        context?.insert(self)
        try? context?.save()
    }
}
