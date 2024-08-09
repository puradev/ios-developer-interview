    //
    //  ThesaurusResponseTests.swift
    //  SampleAppTests
    //
    //  Created by Nic on 8/9/24.
    //

import XCTest
@testable import SampleApp

class ThesaurusResponseTests: XCTestCase {
    
    func testParsingThesaurusResponse() {
        let jsonData = """
        {
            "meta": {
                "id": "testword",
                "syns": [["synonym1", "synonym2"]]
            }
        }
        """.data(using: .utf8)!
        
        do {
            let response = try JSONDecoder().decode(ThesaurusResponse.self, from: jsonData)
            XCTAssertEqual(response.meta.id, "testword")
            XCTAssertEqual(response.meta.syns, [["synonym1", "synonym2"]])
        } catch {
            XCTFail("Failed to parse ThesaurusResponse: \(error)")
        }
    }
}
