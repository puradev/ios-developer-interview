    //
    //  URLBuilderTests.swift
    //  SampleAppTests
    //
    //  Created by Nic on 8/9/24.
    //

import XCTest
@testable import SampleApp

class URLBuilderTests: XCTestCase {
    
    func testDictionaryRequestURL() {
        let builder = URLBuilder(baseURL: "https://www.dictionaryapi.com/api/v3/references/collegiate/json/", word: "testword")
        let url = builder.dictRequestURL
        XCTAssertEqual(url, "https://www.dictionaryapi.com/api/v3/references/collegiate/json/testword?key=0b15979d-724f-4686-8686-dedb9983df50")
    }
    
    func testThesaurusRequestURL() {
        let builder = URLBuilder(baseURL: "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/", word: "testword")
        let url = builder.thesRequestURL
        XCTAssertEqual(url, "https://www.dictionaryapi.com/api/v3/references/thesaurus/json/testword?key=59a05a64-94df-4983-a3b0-a691ea99fcdb")
    }
}
