//
//  IGStoryView.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

@IBDesignable open class IGStoryView: UIView {
    
    @IBInspectable open var borderWidth: CGFloat = 5
    
    
    private var contentView: UIImageView? {
        didSet {
            guard let contentView = contentView else { return }
            contentView.layer.cornerRadius = contentView.frame.width / 2.0
            contentView.clipsToBounds = true
        }
    }
    
    open var image: UIImage? {
        didSet {
            contentView?.image = image
        }
    }
    
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
        guard let contentView = contentView else { return }
        
        // IGStoryView configuration
        layer.cornerRadius = layer.frame.width / 2.0
        layer.borderWidth = borderWidth
        layer.borderColor = UIColor.border.cgColor
        
        // indicator configuration
        let indicatorLayer = CAGradientLayer()
        indicatorLayer.type = .axial
        indicatorLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
        indicatorLayer.frame = CGRect(x: -borderWidth, y: -borderWidth, width: frame.width + borderWidth * 2, height: frame.height + borderWidth * 2)
        indicatorLayer.cornerRadius = indicatorLayer.frame.width / 2.0
        
        layer.addSublayer(indicatorLayer)
        addSubview(contentView)
//        indicatorLayer.fillColor = UIColor.clear.cgColor
//        indicatorLayer.strokeColor = .red
//        indicatorLayer.lineWidth = borderWidth
//        indicatorLayer.path = .init(roundedRect: bounds, cornerWidth: layer.frame.width / 2.0, cornerHeight: layer.frame.width / 2.0, transform: nil)

    }
}
