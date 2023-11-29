import ComposableArchitecture
import SwiftUI

public struct AppFeature: Reducer {
    // MARK: - State
    public struct State: Equatable {
        public var wordSearch: WordSearchFeature.State = .init()
    }

    // MARK: - Action
    public enum Action: Equatable {
        case wordSearch(WordSearchFeature.Action)
    }

    public init() {}

    // MARK: - Reducer Body
    public var body: some Reducer<State, Action> {
        Scope(state: \.wordSearch, action: /Action.wordSearch) {
            WordSearchFeature()
        }
    }
}

public struct AppFeatureRootView: View {
    let store: StoreOf<AppFeature>

    public var body: some View {
        WordSearchFeatureView(
            store: store.scope(state: \.wordSearch, action: { .wordSearch($0) })
        )
    }
}
