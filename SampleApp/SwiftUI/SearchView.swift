//
//  SearchView.swift
//  SampleApp
//
//  Created by Nathan Fulkerson on 1/4/24.
//

import SwiftUI
import API

@Observable
class SearchState {
  var error: APIError?
  var words: [Word] = []
  var query: String = ""
  var isLoading: Bool = false

  func searchTapped() async {
    self.isLoading = true
    let response = await API.shared.fetchWord(query: query)

    switch response {
    case .success(let data):
        guard let response = WordResponse.words(from: data) else {
            return
        }

      self.words = response.map { $0.word }

    case .failure(let error):
      self.words = []
      self.error = error
    }
    self.isLoading = false
  }
}

struct SearchView: View {
  @State var state: SearchState

    var body: some View {
      List {
        ForEach(state.words, id: \.text) { word in
          VStack(alignment: .leading) {
            Text(word.text)
            Text(word.definitions.joined(separator: ","))
          }
        }
      }
      .listStyle(.plain)
      .safeAreaInset(edge: .top) {
        HStack {
          TextField(
            "Search",
            text: $state.query,
            prompt: Text("Search for a word")
          )
          .padding(8)
          .background(
            Color.init(hue: 0, saturation: 0, brightness: 0.95)
            .clipShape(.rect(cornerRadius: 8))
          )

          Button(action: {
            Task {
              await state.searchTapped()
            }
          }, label: {
            if state.isLoading {
              ProgressView().progressViewStyle(.circular)
                .frame(minWidth: 40)
            } else {
              Text("Search")
                .frame(minWidth: 40)
            }
          })
          .buttonStyle(.borderedProminent)
          .disabled(state.isLoading)


        }
        .padding()
        .background(.blue.opacity(0.95))
      }

    }
}

#Preview {
  SearchView(state: SearchState())
}
