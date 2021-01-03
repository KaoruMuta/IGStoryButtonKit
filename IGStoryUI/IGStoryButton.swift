//
//  IGStoryButton.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

@IBDesignable open class IGStoryButton: UIButton {
    
    private enum InitializeType {
        case script
        case interfaceBuilder
    }
    
    public enum DisplayType {
        case seen
        case unseen
        case status
        case none
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
    
    open var statusView: StatusView!
    
    open var type: DisplayType = .none {
        didSet {
            update(by: type)
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
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        contentView.layer.borderColor = UIColor.border.cgColor
    }
    
    private func configure(with type: InitializeType = .interfaceBuilder, image: UIImage? = nil, colors: [UIColor] = [.red, .orange]) {
        // contentView configuration
        contentView = .init(frame: CGRect(x: borderWidth, y: borderWidth, width: frame.width - borderWidth * 2, height: frame.height - borderWidth * 2))
        
        // statusView configuration
        statusView = .init(frame: CGRect(x: contentView.frame.width * 3.0 / 4.0, y: contentView.frame.width * 3.0 / 4.0, width: contentView.frame.width / 3.0, height: contentView.frame.width / 3.0), image: UIImage(named: "ramen"))
        
        // layer configuration
        indicatorLayer = .init()
        let contentViewLayer: CAShapeLayer = {
            let layer = CAShapeLayer()
            layer.frame = contentView.frame
            layer.borderWidth = borderWidth
            layer.borderColor = UIColor.border.cgColor
            layer.cornerRadius = contentView.frame.width / 2.0
            layer.backgroundColor = UIColor.black.cgColor
            return layer
        }()
        
        // additional configuration (reason: didSet is not called in initializer)
        if type == .script {
            contentView.layer.cornerRadius = contentView.frame.width / 2.0
            contentView.clipsToBounds = true
            contentView.image = image
            indicatorLayer.frame = CGRect(x: -borderWidth, y: -borderWidth, width: frame.width + borderWidth * 2, height: frame.height + borderWidth * 2)
            indicatorLayer.cornerRadius = indicatorLayer.frame.width / 2.0
            indicatorLayer.colors = colors.map { $0.cgColor }
        }
        
        // GestureRecognizer configuration
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressed))
        
        // IGStoryView configuration
        layer.cornerRadius = layer.frame.width / 2.0
        contentView.layer.borderWidth = borderWidth
        contentView.layer.borderColor = UIColor.border.cgColor
        layer.addSublayer(indicatorLayer)
        layer.addSublayer(contentViewLayer)
        addSubview(contentView)
        addGestureRecognizer(longPressGestureRecognizer)
    }
}

public extension IGStoryButton {
    func startAnimating(speed: Float = 0.2, alpha: CGFloat = 0.7) {
        rotateAnimation.speed = speed
        indicatorLayer.add(animation: rotateAnimation)
        UIView.animate(withDuration: Parameter.duration, animations: { [weak self] in
            self?.contentView.alpha = alpha
        })
    }
    
    func stopAnimating() {
        indicatorLayer.removeAllAnimations()
        contentView.alpha = 1.0
    }
}

private extension IGStoryButton {
    @objc func didLongPressed(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let originalTransform = transform
            let scaledTransform = originalTransform.scaledBy(x: Parameter.scale, y: Parameter.scale)
            UIView.animate(withDuration: Parameter.duration, animations: { [weak self] in
                self?.transform = scaledTransform
            }) { [weak self] _ in
                guard let originalTransform = self?.transform else { return }
                let scaledTransform = originalTransform.scaledBy(x: Parameter.zoom, y: Parameter.zoom)
                UIView.animate(withDuration: Parameter.duration, animations: { [weak self] in
                    self?.transform = scaledTransform
                })
            }
        }
    }
    
    func update(by type: DisplayType) {
        switch type {
        case .seen:
            indicatorLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        case .unseen:
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .status:
            indicatorLayer.isHidden = true
            statusView.isHidden = false
        case .none:
            indicatorLayer.isHidden = false
            statusView.isHidden = true
        }
    }
}
