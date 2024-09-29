//
//  WordImagesView.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/29/24.
//

import SwiftUI

struct WordImagesView: View {
    @Binding var navigationStack: [Destination]
    let entry: WordEntry

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(entry.imageUrls, id: \.self) { imageUrl in
                    AsyncImage(url: imageUrl) { phase in
                        Self.image(for: phase)
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle(entry.word)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Next") {
                    navigationStack.append(.detailViewSynonyms(entry))
                }
            }
        }
    }
    
    @ViewBuilder
    static func image(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .success(let image):
            image
        case .failure(let error):
            VStack {
                let _ = print("🔥 ASYNC IMAGE ERROR: \(String(describing: error))")
                Image(systemName: "exclamationmark.octagon")
                Text("Error: \(error.localizedDescription)")
            }
        default:
            LoadingImage()
        }
    }
}

#Preview("Live") {
    RootView(viewModel: .init(navigationStack: [
        .detailView(.Previews.happy),
        .detailViewImages(.Previews.happy)
    ]))
}
