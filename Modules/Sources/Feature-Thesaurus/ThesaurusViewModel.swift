import Foundation
import Combine

public final class ThesaurusViewModel: ObservableObject {
    @Published private(set) var state: ThesaurusState
    private let service: ThesaurusService
    private var cancellables: Set<AnyCancellable> = []

    public init(
        initialState: ThesaurusState,
        service: ThesaurusService = .live
    ) {
        self.state = initialState
        self.service = service
    }

    public func fetchThesaurus() {
        state.dataState = .loading

        service
            .fetchThesaurus(state.query)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { [self] response in
                    if case let .failure(error) = response {
                        state.dataState = .error(description: error.description)
                    }
                },
                receiveValue: { [self] value in
                    let thesaurus = value.first
                    state.dataState = .loaded(thesaurus)
                }
            )
            .store(in: &cancellables)
    }
}
