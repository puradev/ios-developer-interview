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
  var query: String = ""
  var status: Status = .new

  enum Status: Equatable {
    case new
    case loading
    case noResults
    case error(APIError)
    case results([Word])
  }

  func searchTapped() async {
    self.status = .loading
    let response = await API.shared.fetchWord(query: query)

    switch response {
    case .success(let data):
      do {
        guard let response = try WordResponse.words(from: data) else {
          self.status = .error(.noData)
          return
        }
        let words = response.map { $0.word }
        self.status = .results(words)
      } catch {
        self.status = .error(.custom(error.localizedDescription))
      }

    case .failure(let error):
      self.status = .error(error)
    }

  }
}

struct SearchView: View {
  @State var state: SearchState

  var body: some View {
    List {
      switch state.status {
      case .results(let words):
        ForEach(words) { word in
          VStack(alignment: .leading) {
            HStack(alignment: .firstTextBaseline) {
              Text(word.text)
                .font(.title)
              Text(word.functionalLabel)
                .font(.callout)
            }
            Text(word.definitions.joined(separator: ","))
          }
        }
      default:
        EmptyView()
      }
    }
    .overlay {
      switch state.status {
      case .new:
        ContentUnavailableView(
          "Search for a word",
          systemImage: "magnifyingglass"
        )
      case .loading:
        ProgressView().progressViewStyle(.circular)
      case .noResults:
        ContentUnavailableView(
          "No results for \(state.query)",
          systemImage: "questionmark.square.dashed"
        )
      case .error(let apiError):
        ContentUnavailableView(
          "Something went wrong",
          systemImage: "exclamationmark.triangle.fill",
          description: Text(apiError.localizedDescription)
        )

      default:
        EmptyView()
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
          .foregroundColor(.black)

          .padding(8)
          .background(
            Color.white
            .clipShape(.rect(cornerRadius: 8))
          )

          Button(action: {
            Task {
              await state.searchTapped()
            }
          }, label: {
            if state.status == .loading {
              ProgressView().progressViewStyle(.circular)
                .frame(minWidth: 40)
            } else {
              Text("Search")
                .frame(minWidth: 40)
            }
          })
          .tint(.white)
          .disabled(state.status == .loading)
        }
        .padding()
        .background(Color.accentColor)
      }

    }
}

#Preview {
  SearchView(state: SearchState())
}
