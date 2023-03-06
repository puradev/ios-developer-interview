import Combine
import Core_Networking
import Foundation

@frozen
public struct WordService {
    public let fetchWord: (String) -> AnyPublisher<[Word], APIError>

    private init(
        fetchWord: @escaping (String) -> AnyPublisher<[Word], APIError>
    ) {
        self.fetchWord = fetchWord
    }
}

public extension WordService {
    static let live: Self = .init(
        fetchWord: { query in
            let api = API()
            let decoder = JSONDecoder()
            let endpoint: WordEndpoint = .fetchWord(query: query)

            return api
                .dataPublisher(for: endpoint)
                .decode(type: [WordDTO].self, decoder: decoder)
                .map { $0.compactMap(Word.init) }
                .mapError { APIError.custom($0.localizedDescription) }
                .eraseToAnyPublisher()
        }
    )
}
