import Foundation

@frozen
public struct Word: Equatable {
    public let text: String
    public let definitions: [String]
}

#if DEBUG
public extension Word {
    static let mock: Self = .init(
        text: "Mock",
        definitions: []
    )
}
#endif
