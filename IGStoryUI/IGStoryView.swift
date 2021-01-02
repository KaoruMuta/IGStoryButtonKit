//
//  IGStoryView.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

@IBDesignable open class IGStoryView: UIView {
    
    @IBInspectable open var borderWidth: CGFloat = 5
    
    open var image: UIImage? {
        didSet {
            contentView.image = image
        }
    }
    
    private var contentView: UIImageView! {
        didSet {
            contentView.layer.cornerRadius = contentView.frame.width / 2.0
            contentView.clipsToBounds = true
        }
    }
    
    private var indicatorLayer: CAGradientLayer! {
        didSet {
            indicatorLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
            indicatorLayer.frame = CGRect(x: -borderWidth, y: -borderWidth, width: frame.width + borderWidth * 2, height: frame.height + borderWidth * 2)
            indicatorLayer.cornerRadius = indicatorLayer.frame.width / 2.0
        }
    }
    
    private let rotateAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: KeyPath.rotation)
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.speed = 0.0
        animation.repeatCount = .infinity
        return animation
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.border.cgColor
    }
    
    private func configure() {
        // contentView configuration
        contentView = UIImageView(frame: CGRect(x: borderWidth, y: borderWidth, width: frame.width - borderWidth * 2, height: frame.height - borderWidth * 2))
        
        // indicator configuration
        indicatorLayer = CAGradientLayer()
        
        // IGStoryView configuration
        layer.cornerRadius = layer.frame.width / 2.0
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.border.cgColor
        layer.addSublayer(indicatorLayer)
        addSubview(contentView)
    }
}

public extension IGStoryView {
    func startLoading(speed: Float = 0.2) {
        rotateAnimation.speed = speed
        indicatorLayer.add(animation: rotateAnimation)
    }
    
    func stopLoading() {
        indicatorLayer.removeAllAnimations()
    }
}
