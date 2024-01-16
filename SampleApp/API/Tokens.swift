//
//  Tokens.swift
//  SampleApp
//
//  Created by natehancock on 6/28/22.
//

import Foundation

//Just had to remove the API Keys from the repo. I moved them into a Config.plist file that is .gitignored.
enum Service: String {
    case Dictionary = "apiKeyDictionary"
    case Thesaurus = "apiKeyThesaurus"
    case Giphy = "apiKeyGiphy"
}

struct Tokens {
    static var apiKeyDict: String {
        return getValue(for: .Dictionary)
    }

    static var apiKeyThes: String {
        return getValue(for: .Thesaurus)
    }

    static var apiKeyGiphy: String {
        return getValue(for: .Giphy)
    }
    
    private static func getValue(for service: Service) -> String {
        let keyName = service.rawValue
        
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let value = plist.object(forKey: keyName) as? String else {
            fatalError("Couldn't find key \(keyName) in config.plist")
        }
        return value
    }
}
