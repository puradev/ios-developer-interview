//
//  WordDetailView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/26/24.
//

import SwiftUI

struct WordDetailView: View {
    let entry: WordEntry
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("WORD: " + entry.word)
                ForEach(entry.definitions, id: \.self) { definition in
                    Text("DEFINITION: " + definition)
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}
