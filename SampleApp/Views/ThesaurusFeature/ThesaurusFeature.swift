import ComposableArchitecture
import SwiftUI

public struct ThesaurusFeature: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public var query: String
        public var isRequestInFlight: Bool = false
        public var inlineError: String?
        public var results: [String] = []
    }

    // MARK: - Action
    public enum Action: Equatable {
        case requestTapped
        case synonymResponse([ThesaurusResponse])
        case requestFailed(message: String)
    }

    @Dependency(\.thesaurusAPI) var thesaurusAPI

    public init() {}

    // MARK: - Reducer Body
    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .requestTapped:
                state.inlineError = nil
                state.isRequestInFlight = true
                return .run { [query = state.query] send in
                    let response = try await thesaurusAPI.fetch(query)
                    await send(.synonymResponse(response))
                } catch: { error, send in
                    print(error)
                    /// TODO: Add error handling for cases
                    /// This is handled in the ``WordSearchFeature`` for an example.
                    await send(.requestFailed(message: "Failed"))
                }
            case let .synonymResponse(response):
                state.isRequestInFlight = false

                if let results = response.first?.meta.syns.first {
                    state.results = results
                } else {
                    state.inlineError = "Sorry, no results available."
                }

                return .none

            case .requestFailed:
                state.isRequestInFlight = false
                state.inlineError = "Sorry, no results available."
                return .none
            }
        }
    }
}

// MARK: - View
public struct ThesaurusFeatureView: View {
    let store: StoreOf<ThesaurusFeature>
    @ObservedObject var viewStore: ViewStoreOf<ThesaurusFeature>

    public init(
        store: StoreOf<ThesaurusFeature>
    ) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    public var body: some View {
        ZStack {
            if viewStore.results.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Need synonyms for \(viewStore.query)?")
                            .font(.system(.subheadline, design: .serif))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ZStack {
                            if viewStore.isRequestInFlight {
                                ProgressView()
                                    .tint(.blue)
                            } else {
                                Button("Request", action: { store.send(.requestTapped) })
                            }
                        }
                        .frame(width: 72, height: 24)
                    }

                    if let error = viewStore.inlineError {
                        Text(error)
                            .font(.caption2)
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity)
            } else {
                VStack(alignment: .leading) {
                    Text("Synonyms for \(viewStore.query)")
                        .font(.system(.title2, design: .serif))

                    VStack(alignment: .leading) {
                        ForEach(viewStore.results, id: \.self) { synonym in
                            Text(synonym)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Divider()
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ThesaurusFeatureView(
        store: .init(
            initialState: ThesaurusFeature.State(query: "Hello"),
            reducer: {
                ThesaurusFeature()
            }
        )
    )
}

#Preview {
    ThesaurusFeatureView(
        store: .init(
            initialState: ThesaurusFeature.State(
                query: "Hello",
                results: ThesaurusResponse.fixture.meta.syns.first ?? []
            ),
            reducer: {
                ThesaurusFeature()
            }
        )
    )
}

#Preview("Failing") {
    ThesaurusFeatureView(
        store: .init(
            initialState: ThesaurusFeature.State(query: "Hello"),
            reducer: {
                ThesaurusFeature()
                    ._printChanges()
            },
            withDependencies: {
                $0.thesaurusAPI = .faililng
            }
        )
    )
}

#Preview("Live") {
    ThesaurusFeatureView(
        store: .init(
            initialState: ThesaurusFeature.State(query: "Hello"),
            reducer: {
                ThesaurusFeature()
                    ._printChanges()
            },
            withDependencies: {
                $0.thesaurusAPI = .liveValue
            }
        )
    )
}
