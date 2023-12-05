//
//  ThesaurusMeta.swift
//  SampleApp
//
//  Created by Sean Machen on 12/4/23.
//

import Foundation

struct ThesaurusMeta {
    let id: String
    let uuid: String
    let synonyms: [String]
    let antonyms: [String]
    let offensive: Bool
}

// MARK: - Decodable
extension ThesaurusMeta: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case synonyms = "syns"
        case antonyms = "ants"
        case offensive
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        uuid = try container.decode(String.self, forKey: .uuid)
        offensive = try container.decode(Bool.self, forKey: .offensive)

        let synonymList = try container.decode([[String]].self, forKey: .synonyms)
        synonyms = synonymList.flatMap({ $0 })

        let antonymList = try container.decode([[String]].self, forKey: .antonyms)
        antonyms = antonymList.flatMap({ $0 })

    }
}

#if DEBUG
// MARK: - Mocks
extension ThesaurusMeta {
    static func makeMock() -> ThesaurusMeta {
        ThesaurusMeta(
            id: "id123",
            uuid: "test-uuid-1234",
            synonyms: ["check", "try"],
            antonyms: ["invalidate"],
            offensive: false
        )
    }
}
#endif
