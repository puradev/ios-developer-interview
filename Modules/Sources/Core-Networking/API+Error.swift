import Foundation

public enum APIError: Error, Equatable {
    case custom(String)

    public var description: String {
        switch self {
        case let .custom(message):
            return message
        }
    }
}
