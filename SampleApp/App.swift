//
//  App.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import SwiftUI
import GiphyUISDK

@main
struct DictionaryApp: App {
    @State var isShowingLaunchView = true
    
    init() {
        Giphy.configure(apiKey: Tokens.apiKeyGiphy)
    }
    
    var body: some Scene {
        WindowGroup {
            if isShowingLaunchView {
                FancyLoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isShowingLaunchView = false
                        }
                    }
            } else {
                HomeView() // Replace with your main content view
            }
        }
    }
}
