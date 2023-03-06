import Feature_Thesaurus
import Foundation
import Root_Elements

public struct WordDefinitionState: Equatable {
    var dataState: DataState<Word?>
    var query: String
    var isThesaurusPresented: Bool
    var isSearchDisabled: Bool {
        query.count < 2 || dataState == .loading
    }

    public init(
        dataState: DataState<Word?> = .idle,
        isThesaurusPresented: Bool = false,
        query: String = ""
    ) {
        self.dataState = dataState
        self.isThesaurusPresented = isThesaurusPresented
        self.query = query
    }
}
