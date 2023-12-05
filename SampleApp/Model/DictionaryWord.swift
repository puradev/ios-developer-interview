//
//  DictionaryWord.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct DictionaryWord: Codable, Equatable {
    let text: String
    let definitions: [String]
}
