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
                                model.fetchWordFromDictionary()
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
                    if let wordResponse = model.wordResponse {
                        WordView(wordResponse: wordResponse)
                    }
                }
                
                .toast(isPresenting: $model.showInvalidWordError){
                    AlertToast(displayMode: .hud, type: .error(.red), title: "Invalid search, try again")
                }
                .toast(isPresenting: $model.showAPIError){
                    AlertToast(type: .error(.red), title: model.apiErrorText)
                }
            }
        }
        .tint(.black)
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.black)
            TextField("Search for Word", text: $model.searchText)
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
