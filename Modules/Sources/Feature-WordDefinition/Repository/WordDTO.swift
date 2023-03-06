import Foundation

@frozen
public struct WordDTO: Decodable {
    public let meta: Meta
    public let shortdef: [String]

    public struct Meta: Decodable {
        public let id: String
    }
}

public extension Word {
    init(dto: WordDTO) {
        self = .init(
            text: dto.meta.id,
            definitions: dto.shortdef
        )
    }
}
