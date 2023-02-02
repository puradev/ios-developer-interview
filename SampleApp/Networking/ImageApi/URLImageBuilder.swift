//
//  URLImageBuilder.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation

struct URLImageBuilder {
    var baseURL: String
    var word: String

    var requestURL: String {
        let url = baseURL + word + "&key=" + TokenImage.apiKeyImag + "&limit=1"
        return url
    }
}


////apple&key=LIVDSRZULELA&limit=1
