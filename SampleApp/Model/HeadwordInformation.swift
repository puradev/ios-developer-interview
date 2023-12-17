//
//  HeadwordInformation.swift
//  SampleApp
//
//  Created by Abraham Done on 12/15/23.
//

import Foundation


struct HeadwordInformation: Codable {
    let headword: String
    let pronunciations: [Pronunciation]?
    
    enum CodingKeys: String, CodingKey {
        case headword = "hw"
        case pronunciations = "prs"
    }
}
