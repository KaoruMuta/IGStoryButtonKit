//
//  XCTest+Precondition.swift
//  IGStoryButtonKitTests
//
//  Created by k_muta on 2021/01/12.
//

import XCTest

extension XCTestCase {
    func expectPreconditionFailure(expectedMessage: String, block: () -> ()) {
        let expect = expectation(description: "failing precondition")
        preconditionClosure = {
            (condition, message, file, line) in
            if !condition {
                expect.fulfill()
                XCTAssertEqual(message, expectedMessage, "precondition message didn't match", file: file, line: line)
            }
        }
        block()
        waitForExpectations(timeout: 2.0, handler: nil)
        preconditionClosure = defaultPreconditionClosure
    }
}

