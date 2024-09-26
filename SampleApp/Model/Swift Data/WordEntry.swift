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
    var word: String { wordResponse.word.text }
    var definitions: [String] { wordResponse.shortdef }
    var id: UUID
    
    init(wordResponse: WordResponse, id: UUID = .init()) {
        self.wordResponse = wordResponse
        self.id = id
    }
}
