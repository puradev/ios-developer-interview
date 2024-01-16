//
//  GiphyMediaView.swift
//  SampleApp
//
//  Created by Nathan Lambson on 1/15/24.
//

import SwiftUI
import SwiftyGif
import GiphyUISDK

//Tried using this one but the documentation they provided wasn't working rendering the gif. The whole giphy sdk is really unstable, even requesting the gif url sucked. I had to manually pull it out and use another framework to render the gifs.
//struct GiphyMediaView: UIViewRepresentable {
//    var media: GPHMedia
//
//    func makeUIView(context: Context) -> GPHMediaView {
//        let mediaView = GPHMediaView()
//        mediaView.media = media
//        mediaView.contentMode = .scaleAspectFill
//
//        return mediaView
//    }
//
//    func updateUIView(_ uiView: GPHMediaView, context: Context) {
//        DispatchQueue.main.async {
//            uiView.media = media
//        }
//    }
//}

//This view relies on UIKit code so we have to do this to make it compatible with SwiftUI
struct AnimatedGifView: UIViewRepresentable {
    @Binding var url: URL

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView(gifURL: self.url)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        DispatchQueue.main.async {
            uiView.setGifFromURL(self.url)
        }
    }
}

