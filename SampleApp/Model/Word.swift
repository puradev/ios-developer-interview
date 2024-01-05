//
//  Word.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct Word: Codable, Identifiable, Equatable {
    let id: String
    var text: String
    var definitions: [String]
    let functionalLabel: String
}
