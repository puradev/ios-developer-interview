import Foundation

public struct ThesaurusMetadata: Codable {
    public var syns: [[String]]
}

extension ThesaurusMetadata: Equatable {}

public struct ThesaurusResponse: Codable {
    public var meta: ThesaurusMetadata
}

extension ThesaurusResponse: Equatable {}

extension ThesaurusResponse {
    static var fixture: ThesaurusResponse {
        ThesaurusResponse(
            meta: ThesaurusMetadata(
                syns: [[
                    "Lorem",
                    "ipsum",
                    "consectetur",
                    "eiusmod"
                ]]
            )
        )
    }
}
