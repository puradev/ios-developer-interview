import Combine
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var word: Word?
    @Published var isLoading = false

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
