//
//  Const.swift
//  IGStoryButtonKit
//
//  Created by k_muta on 2021/01/01.
//

import UIKit

/// constant structure for animation keypath
struct KeyPath {
    static let rotation = "transform.rotation"
}

/// constant structure for animation parameter
struct Parameter {
    static let duration: Double = 0.3
    static let scale: CGFloat = 0.9
}

/// constant structure for color used in gradientlayer
struct Color {
    static let pink = [UIColor.systemPink, UIColor.orange]
    static let black = [UIColor.black, UIColor.lightGray]
    static let green = [UIColor.green, UIColor.green]
    static let clear = [UIColor.clear]
}
