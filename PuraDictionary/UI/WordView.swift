//
//  WordView.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

struct WordView: View {
    var wordResponse: WordResponse
    
    @State private var mode = 0
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Picker("", selection: $mode) {
                Text("Dictionary").tag(0)
                Text("Thesaurus").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            Text(wordResponse.word.text)
                .font(.largeTitle)
                .padding(.leading)
            
            
            Text(wordResponse.fl)
                .font(.title2)
                .italic()
                .padding(.leading)
            
            Text(wordResponse.meta.stems.joined(separator: "; "))
                .font(.caption)
                .fontWeight(.bold)
                .padding(.bottom)
                .padding(.leading)
            
            Text("Definitions")
                .font(.title3)
                .padding(.leading)
            
            List(wordResponse.word.definitions, id: \.self) { def in
                Text("- " + def)
                    .listRowBackground(Color.clear)
                    .padding(.top)
                    .padding(.bottom)
                    .listRowSeparatorTint(colorScheme == .light ? .black : .gray)
            }
            .padding(.top, -25)
            .listStyle(.grouped)
            .listRowBackground(Color.clear)
            .scrollContentBackground(.hidden)
        }
        .navigationBarTitle("", displayMode: .inline)
        .background {
            if colorScheme == .dark {
                LinearGradient(gradient: Gradient(colors: [.black, .yellow]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            } else {
                LinearGradient(gradient: Gradient(colors: [.white, .yellow]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            }
        }
    }
}

#Preview {
    WordView(wordResponse: WordResponse(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: "200122700", stems: ["test", "tests"], offensive: false), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"))
}
