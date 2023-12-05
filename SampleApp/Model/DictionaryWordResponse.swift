//
//  WordResponse.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

struct DictionaryWordResponse: Decodable {
    let meta: DictionaryMeta
    let shortdef: [String]
    
    var word: DictionaryWord {
        DictionaryWord(
            text: meta.stems.first!,
            definitions: shortdef
        )
    }
    
    static func parseData(_ data: Data) -> DictionaryWordResponse? {
        do {
            let response = try JSONDecoder().decode([DictionaryWordResponse].self, from: data)
            return response.first
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }
}

#if DEBUG
// MARK: - Mocks
extension DictionaryWordResponse {
    static func makeMock() -> DictionaryWordResponse {
        DictionaryWordResponse(
            meta: .makeMock(),
            shortdef: ["This is a test word."]
        )
    }
}
#endif
