//
//  URLBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation


struct URLBuilder {
    var baseURL: String
    var word: String
    var thesaurus: Bool

    var requestURL: String {
        let url = baseURL + word + "?key=" + (thesaurus ? Tokens.apiKeyThes : Tokens.apiKeyDict)
        return url
    }
}
