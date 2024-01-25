//
//  SearchSwiftUIView.swift
//  SampleApp
//
//  Created by Drew Needham-Wood on 1/24/24.
//

import SwiftUI

struct SearchSwiftUIView: View {
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
                
            // Loading View
            case .loading:
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(.circular)
                    Spacer()
                }
                
            // Error View
            case .error:
                VStack {
                    Spacer()
                    Text(viewModel.error ?? "")
                    Spacer()
                }
                
            // Dictionary View
            case .loaded:
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Text("Word:")
                            Spacer()
                            Text(viewModel.word?.text ?? "")
                                .foregroundColor(.gray)
                        }
                        .padding([.top, .leading, .trailing], 20)
                        .padding(.bottom, 12)
                        
                        Rectangle()
                            .frame(height: 0.33)
                            .foregroundColor(Color(uiColor: .lightGray))
                            .padding(.leading, 20)
                    }
                    
                    List(viewModel.word?.definitions ?? []) { definition in
                        HStack(alignment: .top, spacing: 8) {
                            Text("Definition:")
                            Text(definition.string)
                                .foregroundColor(.gray)
                                .lineSpacing(-4)
                            Spacer()
                        }
                        .padding([.bottom, .top], 8)
                    }
                    .listStyle(.plain)
                    Spacer()
                }
                
            // Empty View
            default:
                EmptyView()
            }
            
            Spacer()
            
            // Search Field & Button
            HStack(spacing: 16) {
                TextField("Search Term", text: $text)
                    .textFieldStyle(.roundedBorder)
                Button("Search") {
                    viewModel.search(term: text)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.leading, .trailing], 20)
            .padding(.bottom, 24)
        }
    }
}

struct SearchSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSwiftUIView()
    }
}
