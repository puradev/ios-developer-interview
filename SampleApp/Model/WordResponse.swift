//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


public struct WordResponse: Codable {
    let meta: Meta
    let shortdef: [String]
    
    var word: Word {
        return Word(text: meta.stems.first!, definitions: shortdef)
    }
}

extension WordResponse: Equatable {}

extension WordResponse {
    static var fixture: Self {
        WordResponse(
            meta: Meta(
                id: "1",
                uuid: "123",
                sort: "1",
                stems: ["hello"],
                offensive: false
            ),
            shortdef: [
                "Lorem ipsum dolor sit amet",
                "consectetur adipiscing elit",
                "sed do eiusmod tempor",
            ]
        )
    }
}
