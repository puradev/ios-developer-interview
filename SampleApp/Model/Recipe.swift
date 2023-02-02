//
//  Recipe.swift
//  SampleApp
//
//  Created by MacBook on 26/01/23.
//

import Foundation




//struct RecipeResults : Codable{
//    let recipesResults: [Recipe]?
//
//    var thumbnail: String {
//        if let results = recipesResults{
//            if let firsResult = results.first{
//                let thum = firsResult.thumbnail
//                return thum ?? ""
//            }
//        }
//
//        return ""
//    }
//
//
//}


// MARK: - Welcome
struct Welcome : Codable{
    var results: [ResultI]?
    var next: String?
    
    static func parseData(_ data: Data) -> Welcome? {
        do {
            let response = try JSONDecoder().decode(Welcome.self, from: data)
            return response
        } catch {
            print("WORD RESPONSE ERROR: ", error.localizedDescription)
        }
        return nil
    }
}

// MARK: - Result
struct ResultI : Codable{
    var id: String?
    var title: String?
    var contentDescription: String?
    var contentRating: String?
    var h1Title: String?
    var media: [[String: Media]]?
    var bgColor: String?
    var created: Double?
    var itemurl: String?
    var url: String?
   // var tags: [Any?]?
   // var flags: [Any?]?
    var shares: Int?
    var hasaudio: Bool?
    var hascaption: Bool?
    var sourceid: String?
  //  var composite: NSNull?
}

// MARK: - Media
struct Media : Codable{
    var url: String?
    var size: Int?
    var preview: String?
    var dims: [Int]?
    var duration: Double?
}
