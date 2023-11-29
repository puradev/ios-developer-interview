import Dependencies
import Foundation

public struct DictionaryAPI {
    /// https://dictionaryapi.com/products/api-collegiate-dictionary
    public var fetch: (_ query: String) async throws -> [WordResponse]
}

extension DictionaryAPI: DependencyKey {
    public static var liveValue: DictionaryAPI {
        DictionaryAPI(
            fetch: { query in
                try await API.shared.fetch(route: .getDefinition(query))
            }
        )
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
