import Core_Networking

public enum WordEndpoint {
    case fetchWord(query: String)
}

extension WordEndpoint: HTTPRequestProtocol {
    public var path: String {
        switch self {
        case let .fetchWord(word):
            return "\(word)"
        }
    }

    public var parameters: HTTPRequestParameters {
        switch self {
        case .fetchWord:
            return .urlQuery(
                ["key": APITokens.apiKeyDict]
            )
        }
    }
}
