//
//  StatusView.swift
//  IGStoryButtonKit
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

final public class StatusView: UIImageView {
    
    public enum DisplayType {
        case image(of: UIImage?)
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
    func set(image: UIImage?) {
        self.image = image
    }
    
    func set(color: UIColor?) {
        self.image = nil
        self.backgroundColor = color
    }
}
