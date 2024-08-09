    //
    //  WordResponse.swift
    //  SampleApp
    //
    //  Created by Nic on 8/9/24.
    //

import Foundation

struct DictionaryResponse: Decodable {
    
    let meta: Meta
    let shortdef: [String]
    
    struct Meta: Decodable {
        let id: String
    }
}

struct ThesaurusResponse: Decodable {
    
    let meta: Meta
    
    struct Meta: Decodable {
        let id: String
        let syns: [[String]]
    }
}
