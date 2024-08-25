import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var word: Word?

    var body: some View {
        NavigationView {
            ScrollView {
                if let word {
                    VStack {
                        Text("\(word.text)")
                        ForEach(Array(word.definitions.enumerated()), id: \.offset) { index, definition in
                            Text("\(index + 1). \(definition)")
                        }
                    }
                }
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

#Preview {
    ContentView()
}
