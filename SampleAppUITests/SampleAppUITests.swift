//
//  SampleAppUITests.swift
//  SampleAppUITests
//
//  Created by natehancock on 6/28/22.
//

import XCTest

class SampleAppUITests: XCTestCase {

    func testSearchWord() {
        appLaunch()
        typeText("Hello")
        tapSearch()
        checkForTextExistence("An expression or gesture of greeting —used interjectionally in greeting, in answering the telephone, or to express surprise")
    }
    
    func testSearchNonWord() {
        appLaunch()
        typeText("Aoudsiuahsd")
        tapSearch()
        checkForTextExistence("No definitions found")
    }
}
