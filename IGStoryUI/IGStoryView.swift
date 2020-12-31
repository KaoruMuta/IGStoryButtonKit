//
//  IGStoryView.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

@IBDesignable open class IGStoryView: UIView {
    
    @IBInspectable open var borderWidth: CGFloat = 5
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = layer.frame.width / 2.0
        layer.borderWidth = borderWidth
        layer.borderColor = .init(gray: 0.0, alpha: 0.0)
    }
}
