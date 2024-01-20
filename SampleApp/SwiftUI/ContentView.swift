//
//  ContentView.swift
//  SampleApp
//
//  Created by Mark Davis on 1/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var userInput: String = ""
    @State private var wordDefinitions: [Word] = []
    @State private var isApiCallInProgress: Bool = false
    @State private var presentEmptyDefinitionAlert: Bool = false
    @State private var presentApiFailureAlert: Bool = false
    
    var body: some View {
        NavigationView {
            
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
                    ForEach(wordDefinitions) { word in
                        NavigationLink(destination: WordDetailView(word: word)) {
                            WordRowItemView(word: word)
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
    }
    
    func fetchWordDefinition(with word: String) {
        API.shared.fetchWord(query: userInput) { response in
            switch response {
            case .success(let data):
                guard let r = WordResponse.parseData(data) else {
                    presentEmptyDefinitionAlert = true
                    isApiCallInProgress = false
                    return
                }
                
                let definition = r.shortdef[0]
                guard !definition.isEmpty else {
                    presentEmptyDefinitionAlert = true
                    isApiCallInProgress = false
                    return
                }
                self.wordDefinitions.append(r.word)
                isApiCallInProgress = false
                
            case .failure(let error):
                presentApiFailureAlert = true
                isApiCallInProgress = false
                print("NETWORK ERROR: ", error.localizedDescription)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
