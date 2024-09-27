//
//  SynonymsResponse.swift
//  SampleApp
//
//  Created by Benjamin Patch on 9/27/24.
//

import Foundation

struct SynonymsResponse: Codable {
    private let meta: SynonymsMeta
    //    let shortdef: [String]
    var synonyms: [[String]] { meta.syns }
    var antonyms: [[String]] { meta.ants }
}

private struct SynonymsMeta: Codable {
    let syns: [[String]]
    let ants: [[String]]
    //    let offensive: Bool
}

// MARK: Preview Data

extension SynonymsResponse {
    enum Previews {
        static var happy: SynonymsResponse {
            .init(meta:
                    .init(
                        syns: [["fluky", "fortuitous", "fortunate", "heaven-sent", "lucky", "providential"], ["blissful", "chuffed", "delighted", "glad", "gratified", "joyful", "joyous", "pleased", "satisfied", "thankful", "tickled"], ["content", "contented", "gratified", "pleased", "satisfied"], ["fortunate", "lucky"], ["applicable", "appropriate", "apt", "becoming", "befitting", "felicitous", "fit", "fitted", "fitting", "good", "meet", "pretty", "proper", "right", "suitable"], ["hung up", "obsessed", "queer"]],
                        ants: [["hapless", "ill-fated", "ill-starred", "luckless", "star-crossed", "unfortunate", "unhappy", "unlucky"], ["displeased", "dissatisfied", "joyless", "sad", "unhappy", "unpleased", "unsatisfied"], ["discontent", "discontented", "displeased", "dissatisfied", "malcontent", "malcontented", "unhappy"], ["hapless", "ill-fated", "ill-starred", "luckless", "snakebit", "star-crossed", "unfortunate", "unhappy", "unlucky"], ["improper", "inapplicable", "inapposite", "inappropriate", "inapt", "incongruous", "indecent", "infelicitous", "malapropos", "misbecoming", "unapt", "unbecoming", "unbeseeming", "unfit", "unfitting", "unhappy", "unmeet", "unseemly", "unsuitable", "wrong"]]
                    )
            )
        }
    }
}
    
