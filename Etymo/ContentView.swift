import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else if let word = viewModel.word {
                            WordItemView(word: word)
                                .frame(maxWidth: .infinity)
                                .padding()
                        } else if viewModel.searchText.isEmpty {
                            emptySearchView
                                .padding(.bottom, 48)
                                .frame(maxHeight: .infinity, alignment: .center)
                        } else {
                            noResultsView
                                .padding(.bottom, 48)
                                .frame(maxHeight: .infinity, alignment: .center)
                        }
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }
                .navigationTitle("Etymo")
                .searchable(text: $viewModel.searchText, prompt: "Word")
            }
        }
        .overlay {
            if !viewModel.isConnected {
                notConnectedView
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.background)
            }
        }
    }

    var emptySearchView: some View {
        ContentUnavailableView(
            image: Image(.textPageBadgeMagnifyingglass),
            title: "Enter a Word",
            description: "Type a word into the search to see its definitions."
        )
        .tint(.secondary)
    }

    var noResultsView: some View {
        ContentUnavailableView(
            image: Image(.textPageBadgeMagnifyingglass),
            title: "No Results",
            description: "Check the spelling or try a new search."
        )
        .tint(.secondary)
    }

    var notConnectedView: some View {
        ContentUnavailableView(
            image: Image(.wifiSlash),
            title: "Not Connected",
            description: "Unable to lookup words while offline.\nCheck your Internet connection."
        )
        .tint(.red)
    }
}

#Preview {
    ContentView()
}
