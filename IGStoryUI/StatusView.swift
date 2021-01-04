//
//  StatusView.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

// FIXME
final public class StatusView: UIView {
    
    public enum DisplayType {
        case image
        case color
    }
    
    private var imageView: UIImageView = .init()
    private var view: UIView = .init()
    
    init(frame: CGRect, color: UIColor? = nil, image: UIImage? = nil) {
        super.init(frame: frame)
        layer.cornerRadius = frame.width / 2.0
        layer.borderWidth = frame.width / 6.0
        layer.borderColor = UIColor.border.cgColor
        clipsToBounds = true
        
        if let color = color {
            let view = UIView(frame: frame)
            self.view.frame = view.frame.insetBy(dx: layer.borderWidth, dy: layer.borderWidth)
            self.view.backgroundColor = color
        }
        
        if let image = image {
            let imageView = UIImageView(frame: frame)
            self.imageView.frame = imageView.frame.insetBy(dx: layer.borderWidth, dy: layer.borderWidth)
            self.imageView.image = image
        }
        
        addSubview(view)
        addSubview(imageView)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    public func setColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    public func display(type: DisplayType) {
        switch type {
        case .image:
            bringSubviewToFront(imageView)
        case .color:
            bringSubviewToFront(view)
        }
    }
}
