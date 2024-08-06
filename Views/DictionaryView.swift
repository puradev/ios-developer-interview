//
//  DictionaryView.swift
//  SampleApp
//
//  Created by Joshua Brogdon on 8/6/24.
//

import SwiftUI
import Combine

struct DictionaryView: View {
    
    @ObservedObject var viewModel = DictionaryViewModel()
    
    @State var wordToSearch = ""
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Search any word...", text: $wordToSearch)
                            .keyboardType(.alphabet)
                            .padding(10)
                            .background(Color(.systemGray6))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                        Button(action: { viewModel.search(for: wordToSearch) { didFinish(with: $0) } }) {
                            Text("Search")
                        }
                    }
                    .padding()
                    if let wordData = viewModel.wordData, viewModel.noResultsText == nil {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(wordData.searchedWord)
                                .font(.title)
                                .bold()
                                .underline()
                                .padding(.bottom)
                            Text(wordData.wordType)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .padding(.vertical)
                            ForEach(wordData.definitions.indices, id: \.self) { i in
                                if wordData.definitions.count > 1 {
                                    Text("\(i+1). \(wordData.definitions[i])")
                                        .font(.system(size: 18))
                                        .padding(.vertical, 8)
                                } else {
                                    Text("\(wordData.definitions[i])")
                                }
                            }
                        }
                        .padding()
                    }
                    if let noResultsText = viewModel.noResultsText {
                        HStack {
                            Spacer()
                            Text(noResultsText)
                                .lineLimit(1)
                                .font(.title)
                                .bold()
                                .padding()
                            Spacer()
                        }
                        .padding(.top)
                    }
                    Spacer()
                }
            }
            .navigationTitle("LexiFind")
        }
    }
    
    func didFinish(with error: Bool) {
        if !error {
            self.wordToSearch = ""
        }
    }
}

#Preview {
    DictionaryView()
}
