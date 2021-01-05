//
//  Const.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/01.
//

import UIKit

struct KeyPath {
    static let rotation = "transform.rotation"
}

struct Parameter {
    static let duration: Double = 0.3
    static let scale: CGFloat = 0.9
    static let zoom: CGFloat = 1.0 / scale
}

struct Color {
    static let pink = [UIColor.systemPink, UIColor.orange]
    static let black = [UIColor.black, UIColor.lightGray]
    static let green = [UIColor.green, UIColor.green]
    static let clear = [UIColor.clear]
}
