import Foundation

@frozen
public struct Thesaurus: Equatable {
    public let syns: [String]
    public let ants: [String]
}

#if DEBUG
public extension Thesaurus {
    static let mock: Self = .init(
        syns: ["syns"],
        ants: ["ants"]
    )
}
#endif
