//
//  Extensions.swift
//  IGStoryButtonKit
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

extension UIColor {
    /// static variable of UIColor applied to darkmode
    static var border = UIColor {
        $0.userInterfaceStyle == .dark ? .black : .white
    }
}

extension CALayer {
    /// function to add animation to layer without key
    func add<A: CAAnimation>(animation: A, forKey: String? = nil) {
        self.add(animation, forKey: forKey)
    }
}
