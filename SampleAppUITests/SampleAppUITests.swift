    //
    //  SampleAppUITests.swift
    //  SampleAppUITests
    //
    //  Created by natehancock on 6/28/22.
    //

import XCTest

final class SampleAppUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testSearchWord() {
        let app = XCUIApplication()
        app.launch()
        
        let wordTextField = app.textFields["wordTextField"]
        XCTAssertTrue(wordTextField.exists)
        
        wordTextField.tap()
        wordTextField.typeText("test")
        
        let searchButton = app.buttons["searchButton"]
        XCTAssertTrue(searchButton.exists)
        
        searchButton.tap()
        
        let resultsList = app.tables["resultsList"]
        let exists = resultsList.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "The results list did not appear in time")
        
        let firstResult = resultsList.cells.element(boundBy: 0)
        XCTAssertTrue(firstResult.waitForExistence(timeout: 5.0))
    }
    
    func testSwitchRequestType() {
        let app = XCUIApplication()
        app.launch()
        
        let requestTypePicker = app.segmentedControls["requestTypePicker"]
        XCTAssertTrue(requestTypePicker.exists)
        
        let synonymOption = requestTypePicker.buttons["Synonym"]
        synonymOption.tap()
        XCTAssertTrue(synonymOption.isSelected)
        
        let definitionOption = requestTypePicker.buttons["Definition"]
        definitionOption.tap()
        XCTAssertTrue(definitionOption.isSelected)
    }
}
