//
//  WordRowItemView.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

struct WordRowItemView: View {
    var word: Word
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(word.text)
                    .fontWeight(.heavy)
                    .padding(.bottom, 5)
                Text(word.definitions[0])
            } //: VStack
        } //: HStack
    }
}

struct WordRowItemView_Previews: PreviewProvider {
    static var previews: some View {
        WordRowItemView(word: Word(text: "eat", definitions: ["to eat food or nutritious food", "eating substances", "the act of eating"]))
    }
}
