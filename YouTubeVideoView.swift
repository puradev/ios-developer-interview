//
//  YouTubeVideoView.swift
//  SampleApp
//
//  Created by Sean Machen on 12/1/23.
//

import SwiftUI
import WebKit

struct YouTubeVideoView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let videoURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.load(URLRequest(url: videoURL))
    }
}
