//
//  ImageResponse.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/27/24.
//

import Foundation

struct ImageResponse: Codable {
    private let data: [ImageData]
    var imageURLs: [String] { data.map { $0.imageurl }}
//    let errormessage: String
}

struct ImageData: Codable {
    let id: Int
    let imageurl: String
}


extension ImageResponse {
    enum Previews {
        static var happy: [URL] {
            [
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/304")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/1157")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/2622")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/4108")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/5279")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/5673")!,
                URL(string: "http://www.glyffix.com/Image/ShowUploadedImage/5674")!
            ]
        }
    }
}







