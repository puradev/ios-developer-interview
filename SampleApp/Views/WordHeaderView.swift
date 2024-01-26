//
//  WordHeaderView.swift
//  SampleApp
//
//  Header for word details, per part of speech.
//  Created by Dave Wilson on 1/23/24.
//

import SwiftUI

struct WordHeaderView: View {
    @ObservedObject var wordResult: WordResult
    
    var body: some View {
        // use zstack color to show rounded corners
        ZStack {
            Color("MainBGColor")
                .ignoresSafeArea()
            VStack {
                Text(wordResult.text)
                    .font(.system(size: 50.0))
                
                Text(wordResult.word.functionalLabel)
                    .font(.system(size: 17.0))
                
                HStack() {
                    Spacer()
                    Text(wordResult.word.homewordInfo.hw)
                    Spacer()
                    if let pronunciation = wordResult.word.homewordInfo.prs?[0].mw {
                        Text(pronunciation)
                        Spacer()
                    }
                }
                .font(.system(size: 25.0))
                Spacer(minLength:15.0)
            }
            .foregroundColor(.white)
            .background(Color("WordHeadBGColor"))
            .cornerRadius(6.0)
            .clipped()
        }
    }

}

#Preview {
    WordHeaderView(wordResult: WordResult(
        withWord: Word(text: "Foof",
                       definitions: ["Yay", "Bar", "Foo"],
                       homewordInfo: HeadwordInfo(hw: "Foof", prs: [Pronunciation(mw: "foof")]),
                       functionalLabel: "verb"),
        meta:Meta(id: "42",
                  uuid: "867-23-343",
                  sort: "desc",
                  stems: ["Foof","Foofy","Foofed"],
                  offensive: true)
    )
    )
}
