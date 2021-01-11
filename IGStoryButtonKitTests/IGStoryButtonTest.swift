//
//  IGStoryButtonTest.swift
//  IGStoryButtonKitTests
//
//  Created by k_muta on 2020/12/31.
//

import XCTest
@testable import IGStoryButtonKit

final class IGStoryButtonTests: XCTestCase {
    // MARK: - Unit tests for IGStoryButton
    func testInitWithFrame() {
        let storyButton = IGStoryButton()
        XCTAssertEqual(storyButton.frame, .zero)
        storyButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        XCTAssertEqual(storyButton.frame.width, 100)
        XCTAssertEqual(storyButton.frame.height, 100)
    }
    
    func testDisplayTypeAndColorTypeIsValid() {
        let storyButton = IGStoryButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let mockImage: UIImage? = .init()
        
        storyButton.condition = .init(display: .seen)
        XCTAssertEqual(storyButton.displayType, .seen)
        XCTAssertEqual(storyButton.colorType, nil)
        
        storyButton.condition = .init(display: .unseen, color: .default)
        XCTAssertEqual(storyButton.displayType, .unseen)
        XCTAssertEqual(storyButton.colorType, .default)
        
        storyButton.condition = .init(display: .status(type: .color(of: .green)))
        XCTAssertEqual(storyButton.displayType, .status(type: .color(of: .green)))
        XCTAssertNotEqual(storyButton.displayType, .status(type: .color(of: .red)))
        
        storyButton.condition = .init(display: .status(type: .image(of: mockImage)))
        XCTAssertEqual(storyButton.displayType, .status(type: .image(of: mockImage)))
        XCTAssertNotEqual(storyButton.displayType, .status(type: .image(of: nil)))
        
        storyButton.condition = .init(display: .none, color: .custom(colors: [.red, .green]))
        XCTAssertEqual(storyButton.colorType, .custom(colors: [.red, .green]))
        XCTAssertNotEqual(storyButton.colorType, .custom(colors: [.red]))
    }
}
