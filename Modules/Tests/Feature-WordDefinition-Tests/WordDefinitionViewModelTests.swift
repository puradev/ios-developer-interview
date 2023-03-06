import Combine
import Core_Networking
@testable import Feature_WordDefinition
import Root_Elements
import XCTest

final class WordDefinitionViewModelTests: XCTestCase {
    func test_getQuery_shouldReturnQueryProperty() {
        // Given
        let expectedQuery = "apple"
        let sut = WordDefinitionViewModel(
            initialState: .init(query: expectedQuery)
        )

        // When
        let receivedQuery = sut.getQuery()

        // Then
        XCTAssertEqual(expectedQuery, receivedQuery)
    }

    func test_setQuery_shouldChangeStateProperty() {
        // Given
        let expectedQuery = "apple"
        let sut = WordDefinitionViewModel(
            initialState: .init(query: "other word")
        )

        // When
        sut.setQuery(expectedQuery)
        let receivedQuery = sut.state.query

        // Then
        XCTAssertEqual(expectedQuery, receivedQuery)
    }

    func test_isThesaurusPresented_shouldReturnIsThesaurusPresentedProperty() {
        // Given
        let sut = WordDefinitionViewModel(
            initialState: .init(isThesaurusPresented: true)
        )

        // When
        let receivedValue = sut.state.isThesaurusPresented

        // Then
        XCTAssert(receivedValue)
    }

    func test_presentThesaurus_shouldChangeStateProperty() {
        // Given
        let sut = WordDefinitionViewModel(
            initialState: .init(isThesaurusPresented: false)
        )

        // When
        sut.presentThesaurus(true)
        let receivedValue = sut.state.isThesaurusPresented

        // Then
        XCTAssert(receivedValue)
    }

    func test_fetchWord_whenReceiveSuccess_shouldShowData() {
        // Given
        let mock: Word = .mock
        let expectation = XCTestExpectation(description: "Service")
        let expectedDataState: DataState<Word?> = .loaded(mock)
        let sut = WordDefinitionViewModel(
            initialState: .init(
                dataState: .loading
            ),
            service: .init(
                fetchWord: { _ in
                    Just([Word.mock])
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                }
            )
        )

        // When
        sut.fetchWord()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let receivedDataState = sut.state.dataState
            XCTAssertEqual(expectedDataState, receivedDataState)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchWord_whenReceiveError_shouldShowError() {
        // Given
        let mock: APIError = .custom("Mock")
        let expectation = XCTestExpectation(description: "Service")
        let expectedDataState: DataState<Word?> = .error(description: mock.description)
        let sut = WordDefinitionViewModel(
            initialState: .init(
                dataState: .loading
            ),
            service: .init(
                fetchWord: { _ in
                    Fail(error: mock)
                        .eraseToAnyPublisher()
                }
            )
        )

        // When
        sut.fetchWord()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let receivedDataState = sut.state.dataState
            XCTAssertEqual(expectedDataState, receivedDataState)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
