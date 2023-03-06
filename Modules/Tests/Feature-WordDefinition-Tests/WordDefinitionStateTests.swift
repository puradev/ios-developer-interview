@testable import Feature_WordDefinition
import XCTest

final class WordDefinitionStateTests: XCTestCase {
    func test_isSearchDisabled_whenQueryCountIsLessThan2_shouldReturnTrue() {
        // Given
        let sut = WordDefinitionState(query: "a")

        // When
        let isSearchDisabled = sut.isSearchDisabled

        // Then
        XCTAssert(isSearchDisabled)
    }

    func test_isSearchDisabled_whenDataStateIsLoading_shouldReturnTrue() {
        // Given
        let sut = WordDefinitionState(
            dataState: .loading,
            query: "apple"
        )

        // When
        let isSearchDisabled = sut.isSearchDisabled

        // Then
        XCTAssert(isSearchDisabled)
    }

    func test_isSearchDisabled_whenDataStateIsNotLoading_andQueryIsGreaterThan2_shouldReturnFalse() {
        // Given
        let sut = WordDefinitionState(
            dataState: .idle,
            query: "apple"
        )

        // When
        let isSearchDisabled = sut.isSearchDisabled

        // Then
        XCTAssertFalse(isSearchDisabled)
    }
}
