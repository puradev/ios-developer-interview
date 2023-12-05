//
//  URLBuilder.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct URLBuilder {
    let baseURL: String
    let word: String
    let token: String

    var requestURL: String {
        let url = baseURL + word + "?key=" + token
        return url
    }
}
