    //
    //  DictionaryResponseTests.swift
    //  SampleAppTests
    //
    //  Created by Nic on 8/9/24.
    //

import XCTest
@testable import SampleApp

class DictionaryResponseTests: XCTestCase {
    
    func testParsingDictionaryResponse() {
        let jsonData = """
        {
            "meta": {
                "id": "testword"
            },
            "shortdef": ["A test definition"]
        }
        """.data(using: .utf8)!
        
        do {
            let response = try JSONDecoder().decode(DictionaryResponse.self, from: jsonData)
            XCTAssertEqual(response.meta.id, "testword")
            XCTAssertEqual(response.shortdef, ["A test definition"])
        } catch {
            XCTFail("Failed to parse DictionaryResponse: \(error)")
        }
    }
}
