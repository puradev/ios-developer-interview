//
//  Word.swift
//  PuraDictionary
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct Word: Codable, Hashable {
    let meta: Meta
    let shortdef: [String]
    let fl: String // verb, noun, etc.
    
    func title() -> String {
        return meta.stems.first ?? ""
    }
    
    // Handle data from API
    static func parseData(_ data: Data) -> [Word]? {
        do {
            let response = try JSONDecoder().decode([Word].self, from: data)
            return response
        } catch {
            print("DICTIONARY RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }
    
    //Thesaurus - Synonym and Antonym helpers
    func synonymsForShortDefIndex(index: Int) -> String {
        guard let syns = meta.syns, syns.count > index, let defSyns = syns[index], !defSyns.isEmpty else { return "" }
        return defSyns.joined(separator: ", ")
    }
    func antonymsForShortDefIndex(index: Int) -> String {
        guard let ants = meta.ants, ants.count > index, let defAnts = ants[index], !defAnts.isEmpty else { return "" }
        return defAnts.joined(separator: ", ")
    }
    
    // Hashable
    static func == (lhs: Word, rhs: Word) -> Bool {
        return lhs.meta.uuid == rhs.meta.uuid
    }
}

