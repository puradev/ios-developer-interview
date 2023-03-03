//
//  SearchedWordViewModel_Tests.swift
//  SampleAppTests
//
//  Created by Gustavo Colaço on 03/03/23.
//

import XCTest
@testable import SampleApp
import Combine


final class SearchedWordViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_SearchedWordViewModel_hasNoDataBeforeMakingNetwork() {
        //Given
        let viewModel = SearchedWordViewModel()
        
        //Then
        XCTAssertTrue(viewModel.words.isEmpty)
        XCTAssertEqual(viewModel.words.count, 0)
    }
    
    
    func test_SearchedWordViewModel_fetchWord_ShouldReturnItems() {
        //Given
        let viewModel = SearchedWordViewModel()
        
        //When
        let expectation = XCTestExpectation(description: "Should return item after 5 seconds")
        
        viewModel.$words
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchWord(query: "car")
        
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.words.isEmpty)
        XCTAssertGreaterThan(viewModel.words.count, 1)
    }

}
