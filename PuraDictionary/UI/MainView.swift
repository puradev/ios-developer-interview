//
//  MainView.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI
import AlertToast

struct MainView: View {
    @ObservedObject var model: MainViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    searchBar
                        .onSubmit {
                            if !model.searchText.isEmpty {
                                model.fetchWord()
                                model.fetchThesaurus()
                            }
                        }
                    
                    Spacer()
                    Spacer()
                    
                    Text("Powered by Merriam-Webster™")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .padding()
                
                .navigationDestination(isPresented: $model.showWord) {
                    if let dictionaryWords = model.dictionaryWords, let thesaurusWords = model.thesaurusWords {
                        WordView(dictionaryWords: dictionaryWords, thesaurusWords: thesaurusWords)
                    }
                }
                
                .toast(isPresenting: $model.showInvalidWordError){
                    AlertToast(displayMode: .hud, type: .error(.red), title: "Word: " + model.searchText + " not found")
                }
                .toast(isPresenting: $model.showAPIError){
                    AlertToast(type: .error(.red), title: model.apiErrorText)
                }
            }
        }
        .tint(colorScheme == .light ?  .black : .white)
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.black)
            TextField("", text: $model.searchText, prompt: Text("Search for Word").foregroundColor(.gray))
                .foregroundColor(.black)
                .font(Font.system(size: 21))
                .autocorrectionDisabled()
        }
        .padding(7)
        .background(Color.white)
        .cornerRadius(50)
    }
}

#Preview {
    MainView(model: MainViewModel())
}
