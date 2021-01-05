//
//  ContentView.swift
//  IGStoryButtonKit
//
//  Created by k_muta on 2021/01/04.
//

import UIKit

final public class ContentView: UIImageView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.width / 2.0
        clipsToBounds = true
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2.0
    }
}
