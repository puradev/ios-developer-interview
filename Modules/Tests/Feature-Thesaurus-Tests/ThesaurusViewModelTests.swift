import Combine
import Core_Networking
@testable import Feature_Thesaurus
import Root_Elements
import XCTest

final class ThesaurusViewModelTests: XCTestCase {
    func test_fetchThesaurus_whenReceiveSuccess_shouldShowData() {
        // Given
        let mock: Thesaurus = .mock
        let expectation = XCTestExpectation(description: "Service")
        let expectedDataState: DataState<Thesaurus?> = .loaded(mock)
        let sut = ThesaurusViewModel(
            initialState: .init(
                dataState: .loading,
                query: "mock"
            ),
            service: .init(
                fetchThesaurus: { _ in
                    Just([Thesaurus.mock])
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                }
            )
        )

        // When
        sut.fetchThesaurus()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let receivedDataState = sut.state.dataState
            XCTAssertEqual(expectedDataState, receivedDataState)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchThesaurus_whenReceiveError_shouldShowError() {
        // Given
        let mock: APIError = .custom("Mock")
        let expectation = XCTestExpectation(description: "Service")
        let expectedDataState: DataState<Thesaurus?> = .error(description: mock.description)
        let sut = ThesaurusViewModel(
            initialState: .init(
                dataState: .loading,
                query: "mock"
            ),
            service: .init(
                fetchThesaurus: { _ in
                    Fail(error: mock)
                        .eraseToAnyPublisher()
                }
            )
        )

        // When
        sut.fetchThesaurus()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let receivedDataState = sut.state.dataState
            XCTAssertEqual(expectedDataState, receivedDataState)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
