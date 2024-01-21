//
//  WordDetailView.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

struct WordDetailView: View {
    var word: Word
    var body: some View {
        VStack {
            Text(word.text)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.bottom, 15)
            
            if word.hasMultipleDefinitions {
                Text("See all the definitions below!")
            }
            
            List {
                ForEach(word.definitions, id: \.self) { definition in
                    Text(definition)
                }
            }
        } //: VStack
    }
}

struct WordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WordDetailView(word: Word(text: "eat", definitions: ["to eat food", "eating food", "the act of eating"]))
    }
}
