import Foundation
import Root_Elements

public struct WordDefinitionState: Equatable {
    var dataState: DataState<Word?>
    var query: String
    var isSearchDisabled: Bool {
        query.count < 2 || dataState == .loading
    }

    public init(
        dataState: DataState<Word?> = .idle,
        query: String = ""
    ) {
        self.dataState = dataState
        self.query = query
    }
}
