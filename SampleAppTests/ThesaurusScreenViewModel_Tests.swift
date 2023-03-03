//
//  ThesaurusScreenViewModel_Tests.swift
//  SampleAppTests
//
//  Created by Gustavo Colaço on 03/03/23.
//

import XCTest
@testable import SampleApp
import Combine


final class ThesaurusScreenViewModel_Tests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_ThesaurusScreenViewModel_hasNoDataBeforeMakingNetwork() {
        //Given
        let viewModel = ThesaurusScreenViewModel()
        
        //Then
        XCTAssertTrue(viewModel.thesaurus.isEmpty)
        XCTAssertEqual(viewModel.thesaurus.count, 0)
    }
    
    
    func test_ThesaurusScreenViewModel_fetchWord_ShouldReturnItems() {
        //Given
        let viewModel = ThesaurusScreenViewModel()

        //When
        let expectation = XCTestExpectation(description: "Should return item after 5 seconds")

        viewModel.$thesaurus
            .dropFirst()
            .sink { returnedItems in
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchThesaurus(query: "car")

        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertFalse(viewModel.thesaurus.isEmpty)
        XCTAssertGreaterThan(viewModel.thesaurus.count, 1)
    }


}
