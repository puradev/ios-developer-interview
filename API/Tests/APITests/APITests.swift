import XCTest

@testable import API
import XCTestParametrizedMacro

final class APITests: XCTestCase {
  let mockBaseUrl = "https://dictionary.com/api/"
  @Parametrize(input: ["dog", "détente", "M. C. Escher", "&c."])
  func testUrlBuilder(input queryParameter: String) {
    let urlBuilder = URLBuilder(
      baseURL: mockBaseUrl,
      word: queryParameter
    )

    XCTAssertEqual("https://dictionary.com/api/\(queryParameter)?key=\(Tokens.apiKeyDict)", urlBuilder.requestURL)
  }

  @Parametrize(input: ["dog", "détente", "M. C. Escher", "&c."])
  func testValidUrl(input word: String) {
    let urlBuilder = URLBuilder(
      baseURL: mockBaseUrl,
      word: word
    )

    XCTAssertNotNil(URL(string: urlBuilder.requestURL))
  }

  func testValidatePresenceOfKey() {
    let urlBuilder = URLBuilder(
      baseURL: mockBaseUrl, word: "cat"
    )

    let urlComponents = URLComponents(string: urlBuilder.requestURL)

    guard let urlComponents else {
      XCTFail("Invalid component or URL")
      return
    }

    guard let queryItems = urlComponents.queryItems else {
      XCTFail("Missing key")
      return
    }

    XCTAssertTrue(queryItems.contains(where: { item in
      item.name == "key" && item.value == Tokens.apiKeyDict
    }))
  }
}
