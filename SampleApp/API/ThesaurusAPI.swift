import Dependencies
import Foundation

public struct ThesaurusAPI {
    /// https://dictionaryapi.com/products/api-collegiate-thesaurus
    public var fetch: (_ query: String) async throws -> [ThesaurusResponse]
}

extension ThesaurusAPI: DependencyKey {
    public static var liveValue: ThesaurusAPI {
        ThesaurusAPI(
            fetch: { query in
                try await API.shared.fetch(route: .getSynonyms(query))
            }
        )
    }
}

extension ThesaurusAPI: TestDependencyKey {
    public static var testValue: ThesaurusAPI {
        ThesaurusAPI(
            fetch: unimplemented("\(Self.self).fetch")
        )
    }

    public static var previewValue: ThesaurusAPI {
        ThesaurusAPI(
            fetch: { _ in [ThesaurusResponse.fixture] }
        )
    }

    public static var longAsyncPreview: ThesaurusAPI {
        ThesaurusAPI(
            fetch: { _ in
                @Dependency(\.mainQueue) var mainQueue

                try await mainQueue.sleep(for: .seconds(3))

                return [ThesaurusResponse.fixture]
            }
        )
    }

    public static var faililng: ThesaurusAPI {
        ThesaurusAPI(
            fetch: { _ in
                @Dependency(\.mainQueue) var mainQueue

                try await mainQueue.sleep(for: .seconds(3))
                throw APIError.custom("Error")
            }
        )
    }
}

public extension DependencyValues {
    var thesaurusAPI: ThesaurusAPI {
        get { self[ThesaurusAPI.self] }
        set { self[ThesaurusAPI.self] = newValue }
    }
}
