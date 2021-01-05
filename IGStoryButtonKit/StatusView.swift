//
//  StatusView.swift
//  IGStoryButtonKit
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

/// view located at lower right in IGStoryButton
final public class StatusView: UIImageView {
    /// enum for indicating type and deciding what StatusView displays
    public enum DisplayType {
        /// if you want to display image in StatusView, use this and input image (UIImage?) into an argument
        case image(of: UIImage?)
        /// if you want to set color in StatusView, use this and input color (UIColor?) into an argument
        case color(of: UIColor?)
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.width / 2.0
        layer.borderWidth = frame.width / 6.0
        layer.borderColor = UIColor.border.cgColor
        clipsToBounds = true
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2.0
        layer.borderWidth = frame.width / 6.0
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.border.cgColor
    }
}

public extension StatusView {
    /// funciton to set image in StatusView
    func set(image: UIImage?) {
        self.image = image
    }
    /// function to set color in StatusView
    func set(color: UIColor?) {
        self.image = nil
        self.backgroundColor = color
    }
}
