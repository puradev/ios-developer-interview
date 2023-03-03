//
//  ThesaurusResponse.swift
//  SampleApp
//
//  Created by Gustavo Colaço on 03/02/23.
//

import Foundation


struct ThesaurusResponse: Identifiable, Codable {
    var id: Int?
    let meta: ThesaurusMeta?
}
