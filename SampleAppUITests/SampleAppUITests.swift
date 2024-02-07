//
//  SampleAppUITests.swift
//  SampleAppUITests
//
//  Created by natehancock on 6/28/22.
//

import XCTest

class SampleAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWordEntryAndLookup() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let textField = app.textFields["enter a word"]
        textField.tap()
        textField.typeText("Scent")
        app.buttons["Lookup"].tap()
        
        XCTAssert(app.staticTexts["scent"].exists, "Should see a header with word at the top of the screen.")
    }
}
