//
//  DictionaryViewModelTests.swift
//  DictionaryViewModelTests
//
//  Created by natehancock on 6/28/22.
//

import XCTest
@testable import SampleApp

import Combine

class DictionaryViewModelTests: XCTestCase {
    private var viewModel: DictionaryViewModel!

    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        viewModel = DictionaryViewModel(wordNetworker: MockWordNetworker())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        subscriptions.removeAll()
    }

    func testSearchTappedWithNoSearchText() throws {
        XCTAssertEqual(viewModel.viewState, .initalState)
        XCTAssertNil(viewModel.thesaurusWordState)

        let viewStateChangedExpectation = expectation(description: "ViewState changed.")
        viewModel.$viewState
            .dropFirst()
            .sink { viewState in
                viewStateChangedExpectation.fulfill()
                XCTAssertEqual(viewState, .nothingFound)
            }
            .store(in: &subscriptions)

        let thesaurusWordStateChangedExpectation = expectation(description: "ThesaurusWordState changed.")
        viewModel.$thesaurusWordState
            .dropFirst()
            .sink { thesaurusWordState in
                thesaurusWordStateChangedExpectation.fulfill()
                XCTAssertNil(thesaurusWordState)
            }
            .store(in: &subscriptions)

        viewModel.searchTapped()
        wait(for: [viewStateChangedExpectation, thesaurusWordStateChangedExpectation], timeout: 1)
    }

    func testSearchTappedWithSearchText() throws {
        XCTAssertEqual(viewModel.viewState, .initalState)
        XCTAssertNil(viewModel.thesaurusWordState)
        viewModel.searchText = "word"

        let viewStateChangedExpectation = expectation(description: "ViewState changed.")
        viewStateChangedExpectation.expectedFulfillmentCount = 2
        var viewStateChangeCount = 0
        viewModel.$viewState
            .dropFirst()
            .sink { viewState in
                viewStateChangedExpectation.fulfill()
                viewStateChangeCount += 1
                switch viewStateChangeCount {
                case 1:
                    XCTAssertEqual(viewState, .loading)
                case 2:
                    XCTAssertEqual(viewState, .foundWord(DictionaryWord(text: "test", definitions: ["This is a test word."])))
                default:
                    XCTFail("ViewState changed too many times.")
                }
            }
            .store(in: &subscriptions)

        let thesaurusWordStateChangedExpectation = expectation(description: "ThesaurusWordState changed.")
        thesaurusWordStateChangedExpectation.expectedFulfillmentCount = 2
        var thesaurusWordStateChangeCount = 0
        viewModel.$thesaurusWordState
            .dropFirst()
            .sink { thesaurusWordState in
                thesaurusWordStateChangedExpectation.fulfill()
                thesaurusWordStateChangeCount += 1
                switch thesaurusWordStateChangeCount {
                case 1:
                    XCTAssertEqual(thesaurusWordState, .loading)
                case 2:
                    XCTAssertEqual(thesaurusWordState, .foundWord(ThesaurusWord(synonyms: ["check", "try"], antonyms: ["invalidate"])))
                default:
                    XCTFail("ThesaurusWordState changed too many times.")
                }
            }
            .store(in: &subscriptions)
        viewModel.searchTapped()

        wait(for: [viewStateChangedExpectation, thesaurusWordStateChangedExpectation], timeout: 1)
    }
}
