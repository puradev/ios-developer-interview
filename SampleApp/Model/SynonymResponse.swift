//
//  SynonymResponse.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import Foundation

struct SynonymResponse: Codable {
    let meta: Meta?
    
    static func synonyms(from data: Data) throws -> [SynonymResponse]? {
        if let stringArray = try? JSONDecoder().decode([String].self, from: data) {
            //This is a very bizarre case. Every now and then the API will return an array of strings. Not even key-value mappings. I assume these are straight synonyms so I'll attempt to decode the blob. I didn't really have time to look further into this but this is not typically a good practice. This only works because the app only relies on the synonyms being there. Very fragile work around.
            return [SynonymResponse(meta: Meta(id: "fubar", uuid: "fubar", stems: [], offensive: false, syns:[stringArray]))]
        }
        
        return try JSONDecoder().decode([SynonymResponse].self, from: data)
    }
}

struct AltSynonymResponse: Codable {
    let syns: [String]
    
    static func synonyms(from data: Data) throws -> [SynonymResponse]? {
        if let jsonString = String(data: data, encoding: .utf8) {
           print("JSON String: \(jsonString)")
       }
        
        return try JSONDecoder().decode([SynonymResponse].self, from: data)
    }
}

