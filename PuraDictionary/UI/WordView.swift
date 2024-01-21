//
//  WordView.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

struct WordView: View {
    var dictionaryWords: [Word]
    var thesaurusWords: [Word]
    
    @State private var mode = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Picker("", selection: $mode) {
                Text("Dictionary").tag(0)
                Text("Thesaurus").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()
            
            if mode == 0 {
                dictionaryView
            } else {
                thesaurusView
            }
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
    
    var dictionaryView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(dictionaryWords.first?.title() ?? "")
                .font(.largeTitle)
                .padding(.leading)
            
            List(dictionaryWords, id: \.self) { word in
                
                dictionaryCard(word: word)
                    .listRowBackground(Color.clear)
                    .padding(.top)
                    .padding(.bottom)
                    .listRowSeparatorTint(colorScheme == .light ? .black : .gray)
            }
            .listStyle(.grouped)
            .listRowBackground(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
    
    func dictionaryCard(word: Word) -> some View {
        VStack(alignment: .leading) {
            Text(word.fl)
                .font(.title2)
                .italic()
            
            Text(word.meta.stems.joined(separator: "; "))
                .font(.caption)
                .fontWeight(.bold)
                .padding(.bottom)
            
            Text("Definitions")
                .font(.title3)
            ForEach(word.shortdef, id: \.self) { def in
                Text("- " + def)
                    .padding(.bottom)
                
            }
        }
    }
    
    var thesaurusView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(thesaurusWords.first?.title() ?? "")
                .font(.largeTitle)
                .padding(.leading)
            
            List(thesaurusWords, id: \.self) { word in
                
                thesaurusCard(word: word)
                    .listRowBackground(Color.clear)
                    .padding(.top)
                    .padding(.bottom)
                    .listRowSeparatorTint(colorScheme == .light ? .black : .gray)
            }
            .listStyle(.grouped)
            .listRowBackground(Color.clear)
            .scrollContentBackground(.hidden)
        }
    }
    
    func thesaurusCard(word: Word) -> some View {
        VStack(alignment: .leading) {
            Text(word.fl)
                .font(.title2)
                .italic()
            
            
            ForEach(0..<word.shortdef.count, id: \.self) { i in
                
                Text("- " + word.shortdef[i])
                let synonymText = word.synonymsForShortDefIndex(index: i)
                if synonymText != "" {
                    Text("Synonyms")
                        .padding(.leading)
                        .fontWeight(.bold)
                    
                    Text(synonymText)
                        .italic()
                        .padding(.bottom)
                        .padding(.leading)
                }
                
                let antonymText = word.antonymsForShortDefIndex(index: i)
                if antonymText != "" {
                    Text("Antonyms")
                        .padding(.leading)
                        .fontWeight(.bold)
                    
                    Text(antonymText)
                        .italic()
                        .padding(.bottom)
                        .padding(.leading)
                }
            }
        }
    }
}

#Preview {
    WordView(dictionaryWords: [Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: "200122700", stems: ["test", "tests"], offensive: false, syns: [], ants: []), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"), Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: "200122700", stems: ["test", "tests"], offensive: false, syns: [], ants: []), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"), Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: "200122700", stems: ["test", "tests"], offensive: false, syns: [], ants: []), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb")], thesaurusWords: [Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: nil, stems: ["test", "tests"], offensive: false, syns: [["Sample", "Try Out"], ["Strain", "Stretch", "Tax", "Try"],  ["Strain", "Stretch", "Tax", "Try"]], ants: [["Sample", "Try Out"], ["Strain", "Stretch", "Tax", "Try"], ["Strain", "Stretch", "Tax", "Try"]]), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"),Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: nil, stems: ["test", "tests"], offensive: false, syns: [["Sample", "Try Out", "Try Out"], ["Strain", "Stretch", "Tax", "Try"],  ["Strain", "Stretch", "Tax", "Try"]], ants: [["Sample", "Try Out"], ["Strain", "Stretch", "Tax", "Try"], ["Strain", "Stretch", "Tax", "Try"]]), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"), Word(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: nil, stems: ["test", "tests"], offensive: false, syns: [["Sample", "Try Out", "Try Out"], ["Strain", "Stretch", "Tax", "Try"],  ["Strain", "Stretch", "Tax", "Try"]], ants: [["Sample", "Try Out"], ["Strain", "Stretch", "Tax", "Try"], ["Strain", "Stretch", "Tax", "Try"]]), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb")])
    
}
