//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by natehancock on 6/28/22.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiKeysRetrieval() {
        // Assuming you have the correct API keys set up in your Config.plist,
        // these tests should pass if the keys are correctly retrieved.
        XCTAssertNotNil(Tokens.apiKeyDict, "The dictionary API key should not be nil")
        XCTAssertNotNil(Tokens.apiKeyThes, "The thesaurus API key should not be nil")
        XCTAssertNotNil(Tokens.apiKeyGiphy, "The Giphy API key should not be nil")
    }

    func testDictionaryURLBuilder() {
        
        // Check if the URLs contain the base URL, word query, and the corresponding API keys.
        let word = "test"
        let requestURL = URLBuilder(baseURL: API.baseDictionaryURL, word: word.lowercased()).requestDictionaryURL
        
        XCTAssertTrue(requestURL.contains("https://www.dictionaryapi.com/api/v3/references/collegiate/json"), "The dictionary URL should contain the base URL")
        XCTAssertTrue(requestURL.contains("test"), "The dictionary URL should contain the word query")
        XCTAssertTrue(requestURL.contains(Tokens.apiKeyDict), "The dictionary URL should contain the API key")
    }
    
    func testThesaurusURLBuilder() {
        
        // Check if the URLs contain the base URL, word query, and the corresponding API keys.
        let word = "test"
        let requestURL = URLBuilder(baseURL: API.baseThesaurusURL, word: word.lowercased()).requestThesaurusURL
        
        XCTAssertTrue(requestURL.contains("https://www.dictionaryapi.com/api/v3/references/thesaurus/json/"), "The thesaurus URL should contain the base URL")
        XCTAssertTrue(requestURL.contains("test"), "The thesaurus URL should contain the word query")
        XCTAssertTrue(requestURL.contains(Tokens.apiKeyThes), "The thesaurus URL should contain the API key")
    }
}
