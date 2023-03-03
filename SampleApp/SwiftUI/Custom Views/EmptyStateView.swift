//
//  EmptyStateView.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import SwiftUI


struct EmptyStateView: View {
    var body: some View {
        VStack {
            Text("Search for a word!")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding(.bottom, 50)
                
            Image(systemName: "text.word.spacing")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            EmptyStateView()
        }
    }
}
