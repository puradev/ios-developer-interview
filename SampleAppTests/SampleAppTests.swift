//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by natehancock on 6/28/22.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {
    
    func testDecodingWordResponse() {
        guard let url = Bundle.main.url(forResource: "wordResponseTest", withExtension: "json") else {
            XCTFail("Could not find wordResponseTest JSON file")
            return
        }
        guard let sampleWordResponseJsonData: Data = NSData(contentsOf: url) as Data? else {
            XCTFail("Could not retrieve wordResponseTest JSON data")
            return
        }
        
        guard let sampleWordResponse = WordResponse.parseData(sampleWordResponseJsonData) else {
            XCTFail("Could not decode wordResponseTest JSON data")
            return
        }
        
        // Subtest 1: Test essential properties count as expected
        XCTAssertGreaterThan(sampleWordResponse.meta.stems.count, 0)
        XCTAssertEqual(sampleWordResponse.shortdef.count, 3)
        
        // Subtest 2: Test word data was correctly assigned
        XCTAssertEqual(sampleWordResponse.word.text, "voluminous")
        XCTAssertEqual(sampleWordResponse.word.definitions[0], "having or marked by great volume or bulk : large; also : full")
        XCTAssertEqual(sampleWordResponse.word.definitions[1], "numerous")
        XCTAssertEqual(sampleWordResponse.word.definitions[2], "filling or capable of filling a large volume or several volumes")
    }
    
}
