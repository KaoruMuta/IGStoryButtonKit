//
//  CALayer+.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/01.
//

import UIKit

extension CALayer {
    func add<A: CAAnimation>(animation: A, forKey: String? = nil) {
        self.add(animation, forKey: forKey)
    }
}
