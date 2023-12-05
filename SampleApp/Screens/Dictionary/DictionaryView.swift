//
//  DictionaryView.swift
//  SampleApp
//
//  Created by Sean Machen on 12/1/23.
//

import SwiftUI

struct DictionaryView: View {
    @ObservedObject var viewModel: DictionaryViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    switch viewModel.viewState {
                    case .initalState:
                        Text("Welcome to Words!!")
                            .font(.system(size: 17))
                    case .loading:
                        ProgressView()
                            .progressViewStyle(.circular)
                    case .nothingFound:
                        Text("Please enter a word to search for.")
                            .font(.system(size: 17))
                    case .foundWord(let word):
                        makeWordView(for: word)
                    case .error:
                        Text("There was an error when searching for your word.")
                            .font(.system(size: 17))
                    }
                    Spacer()
                }
                .padding(16)
            }
            .navigationBarTitle(Text("Words"), displayMode: .inline)
        }
        .searchable(text: $viewModel.searchText, prompt: Text("Search for a word"))
        .onSubmit(of: .search, viewModel.searchTapped)
    }
}

// MARK: - Subviews
private extension DictionaryView {
    @ViewBuilder
    func makeWordView(for word: DictionaryWord) -> some View {
        let lowercaseWord = word.text.lowercased()

        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 0) {
                Spacer()
                Text(word.text.capitalized)
                    .font(.system(size: 21, weight: .semibold))
                Spacer()
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("Definitions:")
                    .font(.system(size: 17, weight: .semibold))
                ForEach(word.definitions.indices, id: \.self) { definitionIndex in
                    HStack(alignment: .top, spacing: 4) {
                        Text("\(definitionIndex + 1).")
                            .font(.system(size: 17))
                        Text(word.definitions[definitionIndex])
                            .font(.system(size: 17))
                    }
                }
            }
            thesaurusViewIfNeeded
            HStack(spacing: 0) {
                Spacer()
                switch lowercaseWord {
                case "raccoon":
                    YouTubeVideoView(videoID: "S9dBJRfymG8")
                        .frame(width: 300, height: 300)
                case "dog":
                    YouTubeVideoView(videoID: "83m261lAlrs")
                        .frame(width: 300, height: 300)
                case "cat":
                    YouTubeVideoView(videoID: "EAZ3urYgO8E")
                        .frame(width: 300, height: 300)
                case "chicken":
                    AsyncImage(url: URL(string: "https://i.imgflip.com/6v22aj.jpg")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                default:
                    EmptyView()
                }
                Spacer()
            }
        }
        .rotationEffect(.degrees(lowercaseWord == "askew" ? 3 : 0))
        .opacity(lowercaseWord == "transparent" ? 0.5 : 1)
        .frame(maxWidth: lowercaseWord == "narrow" ? 116 : .infinity)
    }

    @ViewBuilder
    var thesaurusViewIfNeeded: some View {
        if let thesaurusWordState = viewModel.thesaurusWordState {
            switch thesaurusWordState {
            case .loading:
                ProgressView()
                    .progressViewStyle(.circular)
            case .foundWord(let thesaurusWord):
                VStack(alignment: .leading, spacing: 4) {
                    Text("Synonyms:")
                        .font(.system(size: 17, weight: .semibold))
                    Text(thesaurusWord.synonymDescription)
                        .font(.system(size: 17))
                    Text("Antonyms:")
                        .font(.system(size: 17, weight: .semibold))
                    Text(thesaurusWord.antonymDescription)
                        .font(.system(size: 17))
                }
            case .error:
                Text("Error finding synonyms and antonyms.")
                    .font(.system(size: 17))
            }
        }
    }
}

#if DEBUG
// MARK: - Preview
struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = DictionaryViewModel(wordNetworker: MockWordNetworker())
        return Group {
            DictionaryView(viewModel: mockViewModel)
                .previewDevice("iPhone 15")
                .preferredColorScheme(.light)
            DictionaryView(viewModel: mockViewModel)
                .previewDevice("iPhone 15")
                .preferredColorScheme(.dark)
            DictionaryView(viewModel: mockViewModel)
                .previewDevice("iPhone SE (3rd generation)")
                .preferredColorScheme(.light)
        }
    }
}
#endif
