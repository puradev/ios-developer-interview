//
//  HeadwordInfo.swift
//  SampleApp
//
//  Created by Dave Wilson on 1/25/24.
//

import Foundation

struct HeadwordInfo: Codable {
    let hw: String
    let prs: [Pronunciation]?
}

struct Pronunciation: Codable {
    let mw: String
}

