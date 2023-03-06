import Foundation

@frozen
public struct ThesaurusDTO: Decodable {
    public let meta: Meta

    public struct Meta: Decodable {
        public let syns: [[String]]
        public let ants: [[String]]
    }
}

public extension Thesaurus {
    init(dto: ThesaurusDTO) {
        self = .init(
            syns: dto.meta.syns.first ?? [],
            ants: dto.meta.ants.first ?? []
        )
    }
}
