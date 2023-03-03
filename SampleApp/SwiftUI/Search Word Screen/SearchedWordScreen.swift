//
//  SearchedWordScreen.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI


struct SearchedWordScreen: View {
    @State var searchText: String = ""
    @StateObject var viewModel = SearchedWordViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Ex: Apple", text: $searchText)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        viewModel.fetchWord(query: searchText)
                    }, label: {
                        Text("Search")
                    })
                    .alert(isPresented: $viewModel.isAlertShowing, content: {
                        Alert(
                            title: Text("Ooops"), message: Text(viewModel.error?.rawValue ?? "Something went wrong"), dismissButton: .cancel(Text("OK"), action: {
                            })
                        )
                    })

                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(.blue)
                    .cornerRadius(5)
                    .padding(.leading, 21)
                }
                .padding(.horizontal, 25)
                .padding(.vertical)
                
                if viewModel.words.isEmpty {
                    EmptyStateView()
                    Spacer()
                } else {
                    Text("Word: \(searchText)")
                    List {
                        Section {
                            if let definitions = viewModel.words.first?.shortdef {
                                ForEach(definitions, id: \.self) { word in
                                    Text("• \(word)")
                                        .listRowSeparator(.hidden)
                                }

                            } else {
                                Text("No definitions available at the moment!")
                            }
                        }  header: {
                            Text("Definitions")
                        }
                        
                        
                    }
                    .listStyle(.plain)
                    .padding(.horizontal, 25)
                    
                    NavigationLink(destination: ThesaurusScreen(word: searchText)) {
                        PuraButton(title: "Check Thesaurus", textColor: .white, backgroundColor: .blue, width: 280, height: 50)
                    }
                    
                    Spacer()
                }
                
            }

            .navigationTitle("Pura Words")
        }
    }
}


struct SearchedWordScreen_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SearchedWordScreen()
        }
    }
}
