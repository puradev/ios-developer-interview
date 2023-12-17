//
//  Sound.swift
//  SampleApp
//
//  Created by Abraham Done on 12/15/23.
//

import Foundation


struct Sound: Codable {
    let audio: String
    
    var subdirectory: String {
        if audio.starts(with: "bix") {
            return "bix"
        } else if audio.starts(with: "gg") {
            return "gg"
        } else if #available(iOS 16.0, *), let regex = try? Regex("^\\d+"), !audio.ranges(of: regex).isEmpty {
            return "number"
        } else {
            return String(audio.first ?? Character(""))
        }
    }
    
    var url: URL? {
        URL(string: "https://media.merriam-webster.com/audio/prons/en/us/mp3/\(subdirectory)/\(audio).mp3")
    }
}
