//
//  WordDefinitionView.swift
//  SampleApp
//
//  Word definition view.
//  Created by Dave Wilson on 1/23/24.
//

import SwiftUI

struct WordDefinitionView: View {
    @ObservedObject var wordResult: WordResult
    var defIdx: Int
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack(alignment: .center, content: {
                Spacer()
                Text(wordResult.definitions[defIdx])
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            })
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color("DefBGColor"))
        .ignoresSafeArea()
        .cornerRadius(6.0)
    }
}

#Preview {
    WordDefinitionView(wordResult: WordResult(
        withWord: Word(text: "Foof", 
                       definitions: ["Yay", "Bar", "Foo"],
                       homewordInfo: HeadwordInfo(hw: "Foof", prs: [Pronunciation(mw: "foof")]),
                       functionalLabel: "verb"),
        meta:Meta(id: "42", 
                  uuid: "867-23-343",
                  sort: "desc",
                  stems: ["Foof","Foofy","Foofed"],
                  offensive: true)
        ),
        defIdx: 2
    )
}
