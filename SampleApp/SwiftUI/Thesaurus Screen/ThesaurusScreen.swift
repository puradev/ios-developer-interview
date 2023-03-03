//
//  ThesaurusScreen.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI


struct ThesaurusScreen: View {
    @State var word: String
    @StateObject var viewModel = ThesaurusScreenViewModel()
    
    var body: some View {
        List {
            Section {
                if let syns = viewModel.thesaurus.first?.meta?.syns.first {
                    ForEach(syns, id: \.self) { syns in
                        Text("• \(syns)")
                            .listRowSeparator(.hidden)
                    }
                    
                } else {
                    Text("No synonyms available at the moment!")
                }
            }  header: {
                Text("Synonyms")
            }
            
            Section {
                if let syns = viewModel.thesaurus.first?.meta?.ants.first {
                    ForEach(syns, id: \.self) { syns in
                        Text("• \(syns)")
                            .listRowSeparator(.hidden)
                    }
                    
                } else {
                    Text("No Antonyms available at the moment!")
                }
            }  header: {
                Text("Antonyms")
            }
        }
        .onAppear {
            print("word: \(word)")
            viewModel.fetchThesaurus(query: word)
        }
        .navigationTitle(word)
    }
    
}

struct ThesaurusScreen_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ThesaurusScreen(word: "Amazon")
        }
    }
}
