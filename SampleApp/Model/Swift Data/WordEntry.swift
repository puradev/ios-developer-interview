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
    var word: String
    var definitions: [String] { wordResponse.shortdef }
    var lastUpdated: Date
    var id: UUID
    
    init(word: String, wordResponse: WordResponse, context: ModelContext?, id: UUID = .init()) {
        self.word = word
        self.wordResponse = wordResponse
        self.id = id
        lastUpdated = .now
        context?.insert(self)
        try? context?.save()
    }
}
