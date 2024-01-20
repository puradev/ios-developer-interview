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
    @State private var isApiCallInProgress: Bool = false
    @State private var presentEmptyDefinitionAlert: Bool = false
    @State private var presentApiFailureAlert: Bool = false
    
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
                    isApiCallInProgress = true
                    print(userInput)
                    fetchWordDefinition(with: userInput)
                }
                .buttonStyle(.borderedProminent)
                .disabled(isApiCallInProgress)
            }

            // Results List
            List {
                ForEach(Array(wordDefinitions.keys), id: \.self) { word in
                    VStack(alignment: .leading) {
                        Text(word)
                            .fontWeight(.heavy)
                            .padding(.bottom, 5)
                        Text(wordDefinitions[word] ?? "")
                    }
                }
            }
            
        } //: VStack
        .padding(15)
        .alert("No definition found, please try again", isPresented: $presentEmptyDefinitionAlert) {
            Button("Ok", action: {
                userInput = ""
            })
        }
        .alert("API failure, please try again", isPresented: $presentApiFailureAlert) {
            Button("Ok", action: {})
        }
    }
    
    func fetchWordDefinition(with word: String) {
        API.shared.fetchWord(query: userInput) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    presentEmptyDefinitionAlert = true
                    return
                }
                
                let definition = r.shortdef[0]
                guard !definition.isEmpty else {
                    presentEmptyDefinitionAlert = true
                    return
                }
                self.wordDefinitions[userInput] = definition
                
            case .failure(let error):
                presentApiFailureAlert = true
                print("NETWORK ERROR: ", error.localizedDescription)
            }
            isApiCallInProgress = false
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
