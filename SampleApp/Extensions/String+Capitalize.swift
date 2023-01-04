//
//  String+Capitalize.swift
//  SampleApp
//
//  Created by Fabriccio De la Mora on 15/12/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
