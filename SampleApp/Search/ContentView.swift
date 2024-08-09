    //
    //  ContentView.swift
    //  SampleApp
    //
    //  Created by Nic on 8/9/24.
    //

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WordViewModel()
    @State private var word: String = ""
    @State private var selection: API.Service = .dictionary
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter a word", text: $word)
                    .accessibilityIdentifier("wordTextField")
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onSubmit {
                        viewModel.fetchWordData(for: word, service: selection)
                    }
                
                Button(action: {
                    viewModel.fetchWordData(for: word, service: selection)
                }) {
                    Text("Search")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .accessibilityIdentifier("searchButton")
            }
            .padding()
            
            Picker("Select Request Type", selection: $selection) {
                Text("Definition").tag(API.Service.dictionary)
                Text("Synonym").tag(API.Service.thesaurus)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selection) { newValue in
                viewModel.fetchWordData(for: word, service: newValue)
            }
            .accessibilityIdentifier("requestTypePicker")
            
            List(viewModel.results, id: \.self) { result in
                Text(result)
            }
            .accessibilityIdentifier("resultsList")
        }
        .padding()
        .onAppear {
            viewModel.fetchWordData(for: word, service: selection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
