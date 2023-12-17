//
//  Pronunciation.swift
//  SampleApp
//
//  Created by Abraham Done on 12/15/23.
//

import Foundation


struct Pronunciation: Codable {
    let formatMerriamWebster: String?
    let labelBefore: String?
    let labelAfter: String?
    let punctuation: String?
    let sound: Sound?
    
    enum CodingKeys: String, CodingKey {
        case formatMerriamWebster = "mw"
        case labelBefore = "l"
        case labelAfter = "l2"
        case punctuation = "pun"
        case sound
    }
}
