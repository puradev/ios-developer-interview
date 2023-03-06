import Combine
@testable import Core_Networking
import XCTest

final class APITests: XCTestCase {
    func test_dataPublisher_whenResponseIsValid_shouldReturnResponseData() {
        // Given
        let validResponse: (data: Data, response: HTTPURLResponse) = (.init(), .fixture(statusCode: 200))
        let urlSessionStub = URLSessionStub()
        urlSessionStub.resultToBeReturned = .success(validResponse)
        let sut = API(
            session: urlSessionStub,
            requestBuilder: RequestDummy()
        )

        var cancelBag = Set<AnyCancellable>()

        // When
        var receivedData: Data?
        let successExpectation = expectation(description: "Successfully received a response")
        sut.dataPublisher(for: HTTPRequestDummy())
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case let .failure(error):
                        XCTFail("Expected success, got error: \(error.localizedDescription)")
                    case .finished:
                        cancelBag.removeAll()
                    }
                },
                receiveValue: { data in
                    successExpectation.fulfill()
                    receivedData = data
                }
            )
            .store(in: &cancelBag)

        // Then
        wait(for: [successExpectation], timeout: 1)
        XCTAssertNotNil(receivedData)
    }

    func test_dataPublisher_whenAnyHTTPRequestErrorOccurs_shouldReturnErrorOfTypeHTTPRequestError() {
        // Given
        let urlSessionStub = URLSessionStub()
        urlSessionStub.resultToBeReturned = .failure(APIError.custom("Mock"))
        let sut = API(
            session: urlSessionStub,
            requestBuilder: RequestDummy()
        )

        var cancelBag = Set<AnyCancellable>()

        // When
        var receivedError: APIError?
        let failureExpectation = expectation(description: "Failed")
        sut.dataPublisher(for: HTTPRequestDummy())
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case let .failure(error):
                        failureExpectation.fulfill()
                        receivedError = error
                        
                    case .finished:
                        cancelBag.removeAll()
                    }
                },
                receiveValue: { data in
                    XCTFail("Expected failure, got success with data: \(data)")
                }
            )
            .store(in: &cancelBag)

        // Then
        wait(for: [failureExpectation], timeout: 1)
        XCTAssertNotNil(receivedError)
    }
}

extension HTTPURLResponse {
    static func fixture(
        url: URL = .dummy(),
        statusCode: Int = -1,
        httpVersion: String? = nil,
        headerFields: [String: String]? = nil
    ) -> HTTPURLResponse {
        guard let fixture = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: httpVersion,
            headerFields: headerFields
        ) else {
            preconditionFailure("This should have never failed...")
        }
        return fixture
    }
}
