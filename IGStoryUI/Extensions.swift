//
//  Extensions.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

extension UIColor {
    static var border = UIColor {
        $0.userInterfaceStyle == .dark ? .black : .white
    }
}

extension CALayer {
    func add<A: CAAnimation>(animation: A, forKey: String? = nil) {
        self.add(animation, forKey: forKey)
    }
}

