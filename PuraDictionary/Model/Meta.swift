//
//  Meta.swift
//  PuraDictionary
//
//  Created by Marcus Brown on 1/20/24.
//

import Foundation

struct Meta: Codable {
    let id: String
    let uuid: String
    let sort: String
    let stems: [String]
    let offensive: Bool
}
