import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var word: Word?

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.fetchWord(query: searchText)
            }
            .store(in: &cancellables)
    }

    private func fetchWord(query: String) {
        API.shared.fetchWord(query: query) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    return
                }

                self.word = r.word
            case .failure(let error):
                self.word = nil
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
    }
}
