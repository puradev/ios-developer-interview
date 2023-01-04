//
//  XCTestCase+App.swift
//  SampleAppUITests
//
//  Created by Fabriccio De la Mora on 15/12/22.
//

import Foundation
import XCTest

extension XCTestCase {
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
    func appLaunch() {
        app.launch()
    }
    
    func typeText(_ text: String) {
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText(text)
    }
    
    func tapSearch() {
        app.buttons["search"].firstMatch.tap()
    }
    
    func checkForTextExistence(_ text: String) {
        XCTAssert(app.staticTexts[text].firstMatch.waitForExistence(timeout: 5.0))
    }
}
