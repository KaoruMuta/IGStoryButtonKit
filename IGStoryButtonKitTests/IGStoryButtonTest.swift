//
//  IGStoryButtonTest.swift
//  IGStoryButtonKitTests
//
//  Created by k_muta on 2020/12/31.
//

import XCTest
@testable import IGStoryButtonKit

final class IGStoryButtonTests: XCTestCase {
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