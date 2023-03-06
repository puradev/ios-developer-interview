import Foundation
import Combine

public final class WordDefinitionViewModel: ObservableObject {
    @Published private(set) var state: WordDefinitionState
    private let service: WordService
    private var cancellables: Set<AnyCancellable> = []

    public init(
        initialState: WordDefinitionState = .init(),
        service: WordService = .live
    ) {
        self.state = initialState
        self.service = service
    }

    public func getQuery() -> String {
        state.query
    }

    public func setQuery(_ query: String) {
        state.query = query
    }

    public func fetchWord() {
        state.dataState = .loading

        service
            .fetchWord(state.query)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [self] response in
                    if case let .failure(error) = response {
                        state.dataState = .error(description: error.description)
                    }
                },
                receiveValue: { [self] value in
                    let word = value.first
                    state.dataState = .loaded(word)
                }
            )
            .store(in: &cancellables)
    }
}
