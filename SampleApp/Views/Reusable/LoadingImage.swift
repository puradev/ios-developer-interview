//
//  LoadingImage.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/29/24.
//

import SwiftUI

struct LoadingImage: View {
    var body: some View {
        ZStack(alignment: .center) {
            ProgressView()
                .progressViewStyle(.circular)
                .controlSize(.extraLarge)
                .tint(Color.yellow)
                .padding(.bottom, 30)
            Image(systemName: "mountain.2.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 50)
        }
        .aspectRatio(1, contentMode: .fit)
        .background(Gradient(colors: [.blue, .blue, .clear, .clear, .clear]), in: RoundedRectangle(cornerSize: .init(width: 20, height: 20)))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoadingImage()
}
