import Combine
import Foundation

public protocol APIProtocol {
    func dataPublisher(
        for request: HTTPRequestProtocol
    ) -> AnyPublisher<Data, APIError>
}

@frozen
public struct API: APIProtocol {
    private let session: URLSessionProtocol
    private let requestBuilder: RequestBuilderProtocol

    public init(
        session: URLSessionProtocol = URLSession.shared,
        requestBuilder: RequestBuilderProtocol = APIRequestBuilder()
    ) {
        self.session = session
        self.requestBuilder = requestBuilder
    }

    public func dataPublisher(
        for request: HTTPRequestProtocol
    ) -> AnyPublisher<Data, APIError> {
        let urlRequest = requestBuilder.build(from: request)
        return session
            .anyDataTaskPublisher(for: urlRequest)
            .map { $0.0 }
            .mapError { APIError.custom($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
}
