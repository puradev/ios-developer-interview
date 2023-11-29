import ComposableArchitecture
import SwiftUI

public struct WordSearchFeature: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public var query: String = ""
        public var inlineError: String?
        public var word: WordResponse?
        public var isWordRequestInFlight: Bool = false
        @PresentationState public var alert: AlertState<Action.Alert>?
        public var thesaurus: ThesaurusFeature.State?
    }

    // MARK: - Action
    public enum Action: Equatable {
        public enum Alert: Equatable {
            case tryAgainTapped
        }

        case alert(PresentationAction<Alert>)
        case thesaurus(ThesaurusFeature.Action)
        case setQuery(query: String)
        case submitTapped
        case wordResponse(words: [WordResponse])
        case wordRequestFailed(message: String)
    }

    @Dependency(\.dictionaryAPI) var dictionaryAPI

    public init() {}

    // MARK: - Reducer Body
    public var body: some Reducer<State, Action> {
        Reduce<State, Action> { state, action in
            switch action {
            case .submitTapped:
                // Remove any whitespaces
                state.query = state.query.trimmingCharacters(in: .whitespacesAndNewlines)

                guard !state.query.isEmpty else {
                    state.inlineError = "Search cannot be empty."
                    return .none
                }

                guard state.query.count > 2 else {
                    state.inlineError = "Search must contain more than 2 characters"
                    return .none
                }

                return submitEffect(&state)

            case let .wordResponse(words):
                state.isWordRequestInFlight = false
                state.word = words.first
                state.thesaurus = .init(query: state.query)
                state.query = ""
                return .none

            case let .setQuery(query):
                state.query = query
                state.inlineError = nil
                return .none

            case let .wordRequestFailed(message):
                state.isWordRequestInFlight = false
                state.alert = AlertState(
                    title: {
                        TextState("Uh oh! 🥺")
                    },
                    actions: {
                        ButtonState(action: .tryAgainTapped) {
                            TextState("Try again")
                        }

                        ButtonState {
                            TextState("Dismiss")
                        }
                    },
                    message: {
                        TextState(message)
                    }
                )

                return .none

            case .alert(.presented(.tryAgainTapped)):
                return submitEffect(&state)

            case .alert(.dismiss):
                state.alert = nil
                return .none

            case .thesaurus:
                return .none
            }
        }
        .ifLet(\.thesaurus, action: /Action.thesaurus) {
            ThesaurusFeature()
        }
    }

    func submitEffect(_ state: inout State) -> Effect<Action> {
        print("Requesting result with query: \(state.query)")
        state.isWordRequestInFlight = true
        return .run { [query = state.query] send in
            let response = try await dictionaryAPI.fetch(query)
            await send(.wordResponse(words: response))

        } catch: { error, send in
            guard let error = error as? APIError else {
                await send(.wordRequestFailed(message: "Request failed. Please try again."))
                return
            }

            switch error {
            case .emptyQuery:
                await send(.wordRequestFailed(message: "Request cannot be empty."))

            case let .tooShort(query):
                await send(.wordRequestFailed(message: "\(query) is too short. Please try a longer word."))

            default:
                await send(.wordRequestFailed(message: "Request failed. Please try again."))
            }
        }
    }
}

// MARK: - View
public struct WordSearchFeatureView: View {
    let store: StoreOf<WordSearchFeature>
    @ObservedObject var viewStore: ViewStoreOf<WordSearchFeature>

    public init(
        store: StoreOf<WordSearchFeature>
    ) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }

    public var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField(
                        "Find a word!",
                        text: viewStore.binding(
                            get: \.query,
                            send: { .setQuery(query: $0) }
                        )
                    )
                    .textFieldStyle(.roundedBorder)
                    .disabled(viewStore.isWordRequestInFlight)

                    ZStack {
                        if viewStore.isWordRequestInFlight {
                            ProgressView()
                                .tint(.blue)
                        } else {
                            Button("Submit", action: { store.send(.submitTapped) })
                        }
                    }
                    .frame(width: 72, height: 24)
                }

                if let inlineError = viewStore.inlineError {
                    Text(inlineError)
                        .foregroundStyle(.red)
                        .font(.subheadline)
                }
            }
            .frame(height: 64, alignment: .top)
            .padding(.top)

            if let word = viewStore.word {
                VStack(alignment: .leading, spacing: 12) {
                    Text(word.word.text)
                        .font(.system(.title2, design: .serif))

                    if word.word.definitions.isEmpty {
                        Text("No defintions, yet 🔍")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(word.word.definitions, id: \.self) { definition in
                                Text(definition)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                    .lineLimit(2)

                                Divider()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            } else {
                VStack(spacing: 12) {
                    Text("Find a word!")
                        .font(.title)
                    Text("Type your favorite words above and define them to your hearts delight.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .padding(.bottom, 64)
            }

            IfLetStore(
                store.scope(
                    state: \.thesaurus,
                    action: { .thesaurus($0) }
                ), 
                then: ThesaurusFeatureView.init(store:)
            )
            .padding(.top)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .alert(store: store.scope(state: \.$alert, action: { .alert($0) }))
    }
}

// MARK: - Preview
#Preview("Delayed preview") {
    WordSearchFeatureView(
        store: .init(
            initialState: .init(),
            reducer: {
                WordSearchFeature()
            },
            withDependencies: {
                $0.dictionaryAPI = .longAsyncPreview
            }
        )
    )
}

#Preview("Failing") {
    WordSearchFeatureView(
        store: .init(
            initialState: .init(word: .fixture),
            reducer: {
                WordSearchFeature()
                    ._printChanges()
            },
            withDependencies: {
                $0.dictionaryAPI = .faililng
            }
        )
    )
}

#Preview("Live") {
    WordSearchFeatureView(
        store: .init(
            initialState: .init(),
            reducer: {
                WordSearchFeature()
                    ._printChanges()
            },
            withDependencies: {
                $0.dictionaryAPI = .liveValue
            }
        )
    )
}
