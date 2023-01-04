//
//  DefinitionSearchView.swift
//  SampleApp
//
//  Created by Fabriccio De la Mora on 15/12/22.
//

import SwiftUI

struct DefinitionSearchView: View {
    
    var viewModel = DefinitionSearchViewModel()
    @State private var definitions = [String]()
    @State var inputText: String = ""
    @State private var alertItem: ErrorMessage?
    @State private var searchThesaurus: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(definitions, id: \.self) { definition in
                    Text(definition)
                }
            }
            .navigationTitle("Dictionary")
            .toolbar {
                Toggle("Thesaurus", isOn: $searchThesaurus)
                    .padding()
                    .toggleStyle(SwitchToggleStyle(tint: .blue))
                    .background(.clear)
            }
        }
        .searchable(text: $inputText)
        .onSubmit(of: .search) {
            viewModel.fetchDefinition(inputText, thesaurus: searchThesaurus) { newDefinitions in
                self.definitions = newDefinitions
            } failure: { errorMessage in
                self.definitions.removeAll()
                alertItem = ErrorMessage(message: errorMessage)
            }
        }
        .alert(item: $alertItem) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .cancel())
        }
    }
}

struct DefinitionSearchView_Previews: PreviewProvider {
    static var previews: some View {
        DefinitionSearchView()
            .preferredColorScheme(.dark)
    }
}
