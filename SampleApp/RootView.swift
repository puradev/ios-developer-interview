//
//  RootView.swift
//  SampleApp
//
//  Created by Kody Holman on 2/6/24.
//

import SwiftUI

struct RootView: View {
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State private var word: String = ""
    
    @State private var lookupTask: Task<Void, Never>?
    @State private var definition: Word?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            if let definition {
                Text(definition.text)
                    .font(.largeTitle)
                    .padding(.horizontal)
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(definition.definitions, id: \.self) { def in
                            HStack {
                                Text(def)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                Spacer()
                Image(systemName: "book")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .foregroundStyle(Color(.systemGray3))
            }
            if definition?.text == "scent" {
                Spacer()
                if let url = Bundle.main.url(forResource: "Pura", withExtension: "usdz") {
                    QuickLookView(fileURL: url)
                }
            }
            Spacer()
            HStack {
                TextField("enter a word", text: $word)
                    .focused($isTextFieldFocused)
                    .onSubmit(lookup)
                Button("Lookup", action: lookup)
                    .buttonStyle(.borderedProminent)
            }
            .padding()
            .background(.bar)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            if let errorMessage {
                Text(errorMessage)
                    .foregroundStyle(Color.red)
                    .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
    
    func lookup() {
        
        isTextFieldFocused = false
        definition = nil
        errorMessage = nil
        
        lookupTask = Task {
            defer { lookupTask = nil }
            do {
                definition = try await WebsterDictionary.lookup(word: word)
                word = ""
            } catch WebsterDictionaryError.parseError {
                errorMessage = "No results"
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    RootView()
}
