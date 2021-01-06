//
//  IGStoryButtonTests.swift
//  IGStoryButtonTests
//
//  Created by k_muta on 2020/12/31.
//

import XCTest
@testable import IGStoryButtonKit

class IGStoryButtonKitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Unit tests
    func testManipulateType() {
        let storyButton = IGStoryButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let mockImage: UIImage? = .init()
        
        storyButton.condition = .init(display: .seen, color: .black)
        XCTAssertEqual(storyButton.colorType, .black)
        XCTAssertNotEqual(storyButton.colorType, .default)
        XCTAssertEqual(storyButton.displayType, .seen)
        XCTAssertNotEqual(storyButton.displayType, .unseen)
        
        storyButton.condition = .init(display: .status(type: .color(of: .green)))
        XCTAssertEqual(storyButton.colorType, nil)
        XCTAssertEqual(storyButton.displayType, .status(type: .color(of: .green)))
        XCTAssertNotEqual(storyButton.displayType, .status(type: .color(of: .red)))
        
        storyButton.condition = .init(display: .status(type: .image(of: mockImage)), color: .default)
        XCTAssertEqual(storyButton.displayType, .status(type: .image(of: mockImage)))
        XCTAssertNotEqual(storyButton.displayType, .status(type: .image(of: nil)))
        
        storyButton.condition = .init(display: .none, color: .custom(colors: [.red, .green]))
        XCTAssertEqual(storyButton.colorType, .custom(colors: [.red, .green]))
        XCTAssertNotEqual(storyButton.colorType, .custom(colors: [.red]))
    }

}
