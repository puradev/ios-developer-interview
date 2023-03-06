import Foundation

public enum HTTPMethod: String {
    case get = "GET"
}

public enum HTTPRequestParameters {
    case urlQuery([String: String])
}

public protocol HTTPRequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: HTTPRequestParameters { get }
}

public extension HTTPRequestProtocol {
    var baseURL: URL { URL(string: "https://www.dictionaryapi.com/api/v3/references")! }
    var method: HTTPMethod { .get }
}

#if DEBUG
// MARK: - Test Doubles
public struct HTTPRequestDummy: HTTPRequestProtocol {
    public init() { }

    public var baseURL: URL { .dummy() }
    public var path: String { "" }
    public var method: HTTPMethod { .get }
    public var parameters: HTTPRequestParameters { .urlQuery([:]) }
}

extension URL {
    public static func dummy() -> Self {
        guard let dummyURL = URL(string: "www.dummy.com") else {
            preconditionFailure("This should have never failed...")
        }
        return dummyURL
    }
}
#endif
