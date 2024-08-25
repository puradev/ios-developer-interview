import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var word: Word?

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        if let word {
                            Text("\(word.text)")
                            ForEach(Array(word.definitions.enumerated()), id: \.offset) { index, definition in
                                Text("\(index + 1). \(definition)")
                            }
                        } else if searchText.isEmpty {
                            emptySearchView
                        } else {
                            noResultsView
                        }
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }

                .navigationTitle("Etymo")
                .searchable(text: $searchText, prompt: "Word")
                .onChange(of: searchText) { text in
                    API.shared.fetchWord(query: text) { response in
                        switch response {
                        case .success(let data):
                            guard let r = WordResponse.parseData(data) else {
                                return
                            }

                            word = r.word
                        case .failure(let error):
                            word = nil
                            print("NETWORK ERROR: ", error.localizedDescription)
                        }
                    }
                }
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
