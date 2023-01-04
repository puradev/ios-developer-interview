//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by natehancock on 6/28/22.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {
    func testSearchWord() throws {
        var definitions = [String]()
        
        API.shared.fetchWord(query: "Hello", thesaurus: false) { response in
            switch response {
            case .success(let data):
                definitions = WordResponse.parseData(data)
            case .failure(_):
                XCTFail()
            }
        }
        
        waitFor(5.0, description: "API Call") {
            XCTAssertTrue(!definitions.isEmpty)
        }
    }
    
    func testSearchNonWord() throws {
        var definitions = [String]()
        
        API.shared.fetchWord(query: "ASdohqowuehouh", thesaurus: false) { response in
            switch response {
            case .success(let data):
                definitions = WordResponse.parseData(data)
            case .failure(_):
                XCTFail()
            }
        }
        
        waitFor(5.0, description: "API Call") {
            XCTAssertTrue(definitions.isEmpty)
        }
    }
}
