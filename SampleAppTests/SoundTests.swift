//
//  SoundTests.swift
//  SampleAppTests
//
//  Created by Abraham Done on 12/15/23.
//

import XCTest
@testable import SampleApp

class SoundTests: XCTestCase {
    
    func testSubdirectory() {
        XCTAssertEqual("bix", Sound(audio: "bixSound").subdirectory)
        XCTAssertEqual("gg", Sound(audio: "ggSound").subdirectory)
        XCTAssertEqual("number", Sound(audio: "3dSound").subdirectory)
        XCTAssertEqual("number", Sound(audio: "123Sound").subdirectory)
        XCTAssertEqual("s", Sound(audio: "start03").subdirectory)
        XCTAssertEqual("o", Sound(audio: "onomatopoeia").subdirectory)
    }
    
}
