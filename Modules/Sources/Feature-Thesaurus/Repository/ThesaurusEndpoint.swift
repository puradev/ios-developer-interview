import Core_Networking

public enum ThesaurusEndpoint {
    case fetchThesaurus(query: String)
}

extension ThesaurusEndpoint: HTTPRequestProtocol {
    public var path: String {
        switch self {
        case let .fetchThesaurus(word):
            return "/thesaurus/json/\(word)"
        }
    }

    public var parameters: HTTPRequestParameters {
        switch self {
        case .fetchThesaurus:
            return .urlQuery(
                ["key": APITokens.apiKeyThes]
            )
        }
    }
}
