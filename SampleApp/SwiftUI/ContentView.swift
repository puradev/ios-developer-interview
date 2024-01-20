//
//  ContentView.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput: String = ""
    @State private var wordDefinitions: [String : String] = [:]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Header
            VStack(alignment: .leading, spacing: 15) {
                Text("Dictionary")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                
                Text("Enter a word below, and see the definition!")
            } //: VStack
            .padding(.bottom, 40)
            
            HStack {
                // Text Entry
                TextField("", text: $userInput, prompt: Text("Enter here"))
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled()
                
                // Submit Button
                Button("Submit") {
                    print(userInput)
                }
                .buttonStyle(.borderedProminent)
            }

            // Results List
            List {
                ForEach(Array(wordDefinitions.keys), id: \.self) { word in
                    VStack(alignment: .leading) {
                        Text(word)
                        Text(wordDefinitions[word] ?? "")
                    }
                }
            }
            
        } //: VStack
        .padding(15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
