import Foundation

public protocol RequestBuilderProtocol {
    func build(from request: HTTPRequestProtocol) -> URLRequest
}

@frozen
public struct APIRequestBuilder: RequestBuilderProtocol {
    public init() {}

    public func build(from request: HTTPRequestProtocol) -> URLRequest {
        let endpoint = request.baseURL.appendingPathComponent(request.path)

        var urlRequest: URLRequest = .init(url: endpoint)
        urlRequest.httpMethod = request.method.rawValue

        guard case let .urlQuery(parameters) = request.parameters else {
            return urlRequest
        }

        guard var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: true) else {
            return urlRequest
        }

        urlComponents.queryItems = parameters.map { .init(name: $0.key, value: $0.value) }
        urlRequest.url = urlComponents.url

        return urlRequest
    }
}

#if DEBUG
public struct RequestDummy: RequestBuilderProtocol {
    public init() { }

    public func build(from request: HTTPRequestProtocol) -> URLRequest {
        .init(url: .dummy())
    }
}
#endif
