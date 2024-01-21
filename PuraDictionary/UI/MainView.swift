//
//  MainView.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var model: ViewModel
    @Environment(\.dismissSearch) private var dismissSearch

    var body: some View {
        NavigationStack {
            VStack {
                Image("app_logo")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Powered by Merriam-Webster™")
                    .font(.caption)
                Spacer()
            }
            .padding()
            .searchable(text: $model.searchText)
            .onSubmit(of: .search) {
                model.performSearch()
                model.searchText = ""
            }
            .navigationDestination(isPresented: $model.showWord) {
                if let wordResponse = model.wordResponse {
                    WordView(wordResponse: wordResponse)
                }
            }
        }
    }
}

#Preview {
    MainView(model: ViewModel())
}
