import Combine
import Core_Networking
import Foundation

@frozen
public struct ThesaurusService {
    public let fetchThesaurus: (String) -> AnyPublisher<[Thesaurus], APIError>

    public init(
        fetchThesaurus: @escaping (String) -> AnyPublisher<[Thesaurus], APIError>
    ) {
        self.fetchThesaurus = fetchThesaurus
    }
}

public extension ThesaurusService {
    static let live: Self = .init(
        fetchThesaurus: { query in
            let api = API()
            let decoder = JSONDecoder()
            let endpoint: ThesaurusEndpoint = .fetchThesaurus(query: query)

            return api
                .dataPublisher(for: endpoint)
                .decode(type: [ThesaurusDTO].self, decoder: decoder)
                .map { $0.compactMap(Thesaurus.init) }
                .mapError { APIError.custom($0.localizedDescription) }
                .eraseToAnyPublisher()
        }
    )
}
