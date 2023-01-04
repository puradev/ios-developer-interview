//
//  XCTest+WaitFor.swift
//  SampleAppTests
//
//  Created by Fabriccio De la Mora on 15/12/22.
//

import Foundation
import XCTest

extension XCTestCase {
    func waitFor(_ timeInSeconds: Double, description: String, completion: (() -> Void)) {

        let dispatchAfter = DispatchTimeInterval.seconds(Int(timeInSeconds))
        let expectation = XCTestExpectation(description: description)

        DispatchQueue.main.asyncAfter(deadline: .now() + dispatchAfter) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds + 1.0)
        
        completion()
    }
}
