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
                            Text("\(word.text)")
                            ForEach(Array(word.definitions.enumerated()), id: \.offset) { index, definition in
                                Text("\(index + 1). \(definition)")
                            }
                        } else if viewModel.searchText.isEmpty {
                            emptySearchView
                        } else {
                            noResultsView
                        }
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }

                .navigationTitle("Etymo")
                .searchable(text: $viewModel.searchText, prompt: "Word")
            }
        }
    }
    
    var emptySearchView: some View {
        VStack(spacing: 8) {
            Image(systemName: "character.cursor.ibeam")
                .font(.largeTitle.weight(.bold))
                .imageScale(.large)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)

            VStack(spacing: 4) {
                Text("Enter a Word")
                    .font(.headline)
                Text("Type a word into the search to see its definitions.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
        }
        .padding(.bottom, 48)
        .frame(maxHeight: .infinity, alignment: .center)
    }

    var noResultsView: some View {
        VStack(spacing: 8) {
            Image(systemName: "text.page.badge.magnifyingglass")
                .font(.largeTitle.weight(.bold))
                .imageScale(.large)
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)

            VStack(spacing: 4) {
                Text("No Results")
                    .font(.headline)
                Text("Check the spelling or try a new search.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
        }
        .padding(.bottom, 48)
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    ContentView()
}
