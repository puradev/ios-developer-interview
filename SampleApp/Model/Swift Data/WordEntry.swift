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
    var imageUrls: [URL]
    var definitions: [String] { wordResponse.shortdef }
    var synonyms: [[String]] { synonymsResponse.synonyms }
    var antonyms: [[String]] { synonymsResponse.antonyms }
    var personalNote: String
    var lastUpdated: Date
    var id: String { word }
    
    init(word: String, definition: WordResponse, synonyms: SynonymsResponse, imageUrls: [URL], context: ModelContext?) {
        self.word = word
        wordResponse = definition
        synonymsResponse = synonyms
        self.imageUrls = imageUrls
        lastUpdated = .now
        personalNote = ""
        context?.insert(self)
        try? context?.save()
    }
    
}

extension WordEntry {
    enum Previews {
        static var happy: WordEntry {
            .init(word: "Happy", definition: .Previews.happy, synonyms: .Previews.happy, imageUrls: ImageResponse.Previews.happy, context: nil)
        }
    }
}
