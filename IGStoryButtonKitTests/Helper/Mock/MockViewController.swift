//
//  MockViewController.swift
//  IGStoryButtonKitTests
//
//  Created by k_muta on 2021/01/11.
//

import UIKit
import IGStoryButtonKit

final class MockViewController: UIViewController, IGStoryButtonDelegate {
    var isTapped: Bool = false
    var isLongPressed: Bool = false
    
    func didTapped() {
        isTapped = true
    }
    
    func didLongPressed() {
        isLongPressed = true
    }
}
