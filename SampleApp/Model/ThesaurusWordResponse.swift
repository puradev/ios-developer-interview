//
//  ThesaurusWordResponse.swift
//  SampleApp
//
//  Created by Sean Machen on 12/4/23.
//

import Foundation

struct ThesaurusWordResponse: Decodable {
    let meta: ThesaurusMeta

    var word: ThesaurusWord {
        ThesaurusWord(
            synonyms: meta.synonyms,
            antonyms: meta.antonyms
        )
    }

    static func parseData(_ data: Data) -> ThesaurusWordResponse? {
        do {
            let response = try JSONDecoder().decode([ThesaurusWordResponse].self, from: data)
            return response.first
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }
}

#if DEBUG
// MARK: - Mocks
extension ThesaurusWordResponse {
    static func makeMock() -> ThesaurusWordResponse {
        ThesaurusWordResponse(meta: .makeMock())
    }
}
#endif
