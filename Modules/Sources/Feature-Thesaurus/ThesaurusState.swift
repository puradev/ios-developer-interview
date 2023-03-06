import Foundation
import Root_Elements

public struct ThesaurusState: Equatable {
    var dataState: DataState<Thesaurus?>
    let query: String

    public init(
        dataState: DataState<Thesaurus?> = .loading,
        query: String
    ) {
        self.dataState = dataState
        self.query = query
    }
}
