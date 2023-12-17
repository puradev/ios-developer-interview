//
//  WordEntry.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct WordEntry: Codable {
    let meta: Meta
    let functionalLabel: String
    let homograph: Int?
    let headwordInformation: HeadwordInformation
    let shortDefinitions: [String]
    
    enum CodingKeys: String, CodingKey {
        case meta
        case functionalLabel = "fl"
        case homograph = "hom"
        case headwordInformation = "hwi"
        case shortDefinitions = "shortdef"
    }
    
    static func parseData(_ data: Data) -> [WordEntry] {
        do {
            return try JSONDecoder().decode([WordEntry].self, from: data)
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return []
    }
    
    var sectionTitle: String {
        headwordInformation.headword + (homograph == nil ? "" : " \(homograph!)")
    }
    
    var pronunciationsCount: Int {
        headwordInformation.pronunciations?.count ?? 0
    }
}
