import Dependencies

public struct DictionaryAPI {
    public var fetch: (_ query: String) async throws -> [WordResponse]
}

extension DictionaryAPI: DependencyKey {
    public static var liveValue: DictionaryAPI {
        Self(fetch: API.shared.fetch(word:))
    }
}

extension DictionaryAPI: TestDependencyKey {
    public static var testValue: DictionaryAPI {
        DictionaryAPI(
            fetch: unimplemented("\(Self.self).fetch")
        )
    }

    public static var previewValue: DictionaryAPI {
        DictionaryAPI(
            fetch: { _ in [.fixture] }
        )
    }

    public static var longAsyncPreview: DictionaryAPI {
        DictionaryAPI(
            fetch: { _ in
                @Dependency(\.mainQueue) var mainQueue

                try await mainQueue.sleep(for: .seconds(3))

                return [.fixture]
            }
        )
    }

    public static var faililng: DictionaryAPI {
        DictionaryAPI(
            fetch: { _ in
                @Dependency(\.mainQueue) var mainQueue

                try await mainQueue.sleep(for: .seconds(3))
                throw APIError.custom("Error")
            }
        )
    }
}

public extension DependencyValues {
    var dictionaryAPI: DictionaryAPI {
        get { self[DictionaryAPI.self] }
        set { self[DictionaryAPI.self] = newValue }
    }
}
