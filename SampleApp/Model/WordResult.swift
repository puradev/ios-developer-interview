//
//  WordResult.swift
//  SampleApp
//
//  Observale wrapper to use existing model in SwiftUI. Real world would eval changing the current model struct to class,
//  but pretending black box, low existing impact SwiftUI miagration
//
//  Created by Dave Wilson on 1/23/24.
//

import Foundation

class WordResult: ObservableObject {
    @Published var word: Word
    @Published var meta: Meta?
    
    public var text: String {
        get {
            return word.text
        }
    }
    
    public var definitions: [String] {
        get {
            return word.definitions
        }
    }
    
    init(withWord word: Word, meta: Meta?) {
        self.word = word
        self.meta = meta
    }
    
    init(withWord word: Word) {
        self.word = word
        self.meta = nil
    }
    
}
