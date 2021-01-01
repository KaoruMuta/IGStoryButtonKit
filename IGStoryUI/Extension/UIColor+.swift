//
//  UIColor+.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/01.
//

import UIKit

extension UIColor {
    static var border = UIColor {
        $0.userInterfaceStyle == .dark ? .black : .white
    }
}
