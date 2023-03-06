import Foundation

@frozen
public struct Word: Equatable {
    public let text: String
    public let definitions: [String]
}
