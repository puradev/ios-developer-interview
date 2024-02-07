//
//  Word.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct Word: Codable {
    var text: String
    var definitions: [String]
    
    init?(text: String?, definitions: [String]) {
        guard let text else {
            return nil
        }
        self.text = text
        self.definitions = definitions
    }
}
