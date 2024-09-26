//
//  WordDetailView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI

struct WordDetailView: View {
    let response: WordResponse
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("WORD: " + response.word.text)
                ForEach(response.shortdef, id: \.self) { definition in
                    Text("DEFINITION: " + definition)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}
