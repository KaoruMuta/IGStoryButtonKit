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
            contentView?.layer.cornerRadius = frame.width / 2.0
            contentView?.clipsToBounds = true
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
    
    private func configure() {
        // contentView configuration
        contentView = UIImageView(frame: CGRect(x: borderWidth, y: borderWidth, width: frame.width - borderWidth * 2, height: frame.height - borderWidth * 2))
        guard let contentView = contentView else { return }
        addSubview(contentView)
        
        // IGStoryView configuration
        layer.cornerRadius = layer.frame.width / 2.0
        layer.borderWidth = borderWidth
        layer.borderColor = .init(gray: 0.0, alpha: 0.0)
        
        // indicator configuration
        let indicatorLayer = CAShapeLayer()
        indicatorLayer.fillColor = UIColor.clear.cgColor
        indicatorLayer.strokeColor = .init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        indicatorLayer.lineWidth = borderWidth
        indicatorLayer.path = .init(roundedRect: bounds, cornerWidth: layer.frame.width / 2.0, cornerHeight: layer.frame.width / 2.0, transform: nil)
        layer.addSublayer(indicatorLayer)
    }
}
