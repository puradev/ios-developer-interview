//
//  WordView.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import SwiftUI

struct WordView: View {
    var wordResponse: WordResponse
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(wordResponse.word.text)
                .font(.largeTitle)
                .padding(.leading)
            
            
            Text(wordResponse.fl)
                .padding(.leading)
            
            Text(wordResponse.meta.stems.joined(separator: "; "))
                .fontWeight(.bold)
                .padding(.bottom)
                .padding(.leading)
            
            Text("Definitions")
                .padding(.leading)
            
            List(wordResponse.word.definitions, id: \.self) { def in
                Text(def)
            }
        }
        .navigationBarTitle("", displayMode: .inline)

    }
}

#Preview {
    WordView(wordResponse: WordResponse(meta: Meta(id: "test:1", uuid: "0e5228e3-40df-4dce-92e0-36748eb1c24c", sort: "200122700", stems: ["test", "tests"], offensive: false), shortdef: ["a means of testing: such as", "something (such as a series of questions or exercises) for measuring the skill, knowledge, intelligence, capacities, or aptitudes of an individual or group", "a procedure, reaction, or reagent used to identify or characterize a substance or constituent"], fl: "verb"))
}
