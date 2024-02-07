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

    func testLookupDictionary() async throws {
        let result = try await WebsterDictionary.lookup(word: "scent", type: .dictionary)
        XCTAssert(result.text == "scent", "First stem should be looked up word")
        XCTAssert(result.definitions.isEmpty == false, "Should be getting definitions for looked up word")
    }
    
    func testLookupThesaurus() async throws {
        let result = try await WebsterDictionary.lookup(word: "scent", type: .thesaurus)
        XCTAssert(result.text == "scent", "First stem should be looked up word")
        XCTAssert(result.definitions.isEmpty == false, "Should be getting definitions for looked up word")
    }
    
    func testBadLookupDictionary() async throws {
        do {
            _ = try await WebsterDictionary.lookup(word: "5555", type: .thesaurus)
            XCTFail("Should throw an error")
        } catch {
            
        }
    }
    
    func testBadLookupDictionary2() async throws {
        do {
            _ = try await WebsterDictionary.lookup(word: "Pura", type: .thesaurus)
            XCTFail("Should throw an error")
        } catch {
            
        }
    }
}
