//
//  IGStoryView.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

@IBDesignable open class IGStoryView: UIView {
    
    private enum InitializeType {
        case script
        case interfaceBuilder
    }

    private let borderWidth: CGFloat = 3
    
    open var image: UIImage? {
        didSet {
            contentView.image = image
        }
    }
    
    open var colors: [UIColor] = [.red, .orange] {
        didSet {
            indicatorLayer.colors = colors.map { $0.cgColor }
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
    
    public init(frame: CGRect, image: UIImage? = nil, colors: [UIColor] = [.red, .orange]) {
        super.init(frame: frame)
        configure(with: .script, image: image, colors: colors)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = UIColor.border.cgColor
    }
    
    private func configure(with type: InitializeType = .interfaceBuilder, image: UIImage? = nil, colors: [UIColor] = [.red, .orange]) {
        // contentView configuration
        contentView = UIImageView(frame: CGRect(x: borderWidth, y: borderWidth, width: frame.width - borderWidth * 2, height: frame.height - borderWidth * 2))
        
        // indicator configuration
        indicatorLayer = CAGradientLayer()
        
        if type == .script {
            // additional configuration (reason: didSet is not called in initializer)
            contentView.layer.cornerRadius = contentView.frame.width / 2.0
            contentView.clipsToBounds = true
            contentView.image = image
            indicatorLayer.frame = CGRect(x: -borderWidth, y: -borderWidth, width: frame.width + borderWidth * 2, height: frame.height + borderWidth * 2)
            indicatorLayer.cornerRadius = indicatorLayer.frame.width / 2.0
            indicatorLayer.colors = colors.map { $0.cgColor }
        }
        
        // IGStoryView configuration
        layer.cornerRadius = layer.frame.width / 2.0
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.border.cgColor
        layer.addSublayer(indicatorLayer)
        addSubview(contentView)
    }
}

public extension IGStoryView {
    func startAnimating(speed: Float = 0.2) {
        rotateAnimation.speed = speed
        indicatorLayer.add(animation: rotateAnimation)
    }
    
    func stopAnimating() {
        indicatorLayer.removeAllAnimations()
    }
}
