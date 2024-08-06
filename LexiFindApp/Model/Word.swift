//
//  Word.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct Word: Codable {
    var searchedWord: String
    var altWords: [String]?
    var definitions: [String]
    var wordType: String
}
