    //
    //  WordViewModelTests.swift
    //  SampleAppTests
    //
    //  Created by Nic on 8/9/24.
    //

import XCTest
import Combine

@testable import SampleApp

class WordViewModelTests: XCTestCase {
    
    var viewModel: WordViewModel!
    let testData = """
    [{
        "meta": {
            "id": "testword"
        },
        "shortdef": ["A test definition"]
    }]
    """
    
    override func setUp() {
        super.setUp()
        viewModel = WordViewModel()
    }
    
    func testFetchWordDataWithEmptyWord() {
        viewModel.fetchWordData(for: "", service: .dictionary)
        XCTAssertEqual(viewModel.results, [])
    }
    
    func testFetchWordDataWithValidWord() {
        let expectation = self.expectation(description: "Fetching word data")
        viewModel.$results
            .sink { results in
                if !results.isEmpty {
                    XCTAssertTrue(results.contains("A test definition"))
                    expectation.fulfill()
                }
            }
            .store(in: &viewModel.testableCancellables)
        let data = testData.data(using: .utf8)!
        viewModel.testableHandleSuccess(data: data, word: "testword", service: .dictionary)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testManualDecoding() {
        let data = testData.data(using: .utf8)!
        do {
            let response = try JSONDecoder().decode([DictionaryResponse].self, from: data)
            XCTAssertEqual(response.first?.meta.id, "testword")
            XCTAssertEqual(response.first?.shortdef, ["A test definition"])
        } catch {
            XCTFail("Decoding failed with error: \(error)")
        }
    }
}
