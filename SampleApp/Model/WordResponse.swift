//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct WordResponse: Codable {
    let meta: Meta
    let shortdef: [String]
    
    var word: Word {
        return Word(text: meta.stems.first!, definitions: shortdef)
    }
}

extension WordResponse {
    enum Previews {
        static var happy: WordResponse {
            .init(meta: .init(id: "Happy", uuid: "123", sort: "", stems: [""], offensive: false), shortdef: ["favored by luck or fortune : fortunate", "notably fitting, effective, or well adapted : felicitous", "enjoying or characterized by well-being and contentment"])
        }
    }
}
