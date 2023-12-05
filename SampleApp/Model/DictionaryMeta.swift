//
//  DictionaryMeta.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct DictionaryMeta: Decodable {
    let id: String
    let uuid: String
    let sort: String
    let stems: [String]
    let offensive: Bool
}

#if DEBUG
// MARK: - Mocks
extension DictionaryMeta {
    static func makeMock() -> DictionaryMeta {
        DictionaryMeta(
            id: "id123",
            uuid: "test-uuid-1234",
            sort: "54321",
            stems: ["test", "tests"],
            offensive: false
        )
    }
}
#endif
