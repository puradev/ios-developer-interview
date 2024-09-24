import Combine
import Network
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var word: Word?
    @Published var isLoading = false
    @Published var isConnected = true

    private let networkMonitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.fetchWord(query: searchText)
            }
            .store(in: &cancellables)

        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: queue)
    }

    private func fetchWord(query: String) {
        isLoading = true

        API.shared.fetchWord(query: query) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    return
                }

                DispatchQueue.main.async {
                    self.word = r.word
                    self.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.word = nil
                    self.isLoading = false
                }
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
    }
}
