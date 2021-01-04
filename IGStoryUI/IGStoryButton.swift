//
//  IGStoryButton.swift
//  IGStoryUI
//
//  Created by k_muta on 2020/12/31.
//

import UIKit

/// IGStoryButtonDelegate: By conforming this Delegate, tap event and long pressed event are detected
public protocol IGStoryButtonDelegate: class {
    /// didTapped: In this closure, any action you want should be operated on tap event
    func didTapped()
    /// didLongPressed: In this closure, any action you want should be operated on long press event
    func didLongPressed()
}

@IBDesignable open class IGStoryButton: UIButton {
    // MARK: - public access property
    public enum DisplayType: Equatable {
        case seen
        case unseen
        case status(type: StatusView.DisplayType)
        case none
        
        public static func == (lhs: IGStoryButton.DisplayType, rhs: IGStoryButton.DisplayType) -> Bool {
            switch (lhs, rhs) {
            case (.seen, .seen), (.unseen, .unseen), (.none, .none):
                return true
            case (.status(type: .color(let lhsColor)), .status(type: .color(let rhsColor))):
                return lhsColor == rhsColor
            case (.status(type: .image(let lhsImage)), .status(type: .image(let rhsImage))):
                return lhsImage == rhsImage
            default:
                return false
            }
        }
    }
    
    public weak var delegate: IGStoryButtonDelegate?
    
    public var statusView: StatusView!
    
    public var image: UIImage? {
        didSet {
            contentView.image = image
        }
    }
    
    public var colors: [UIColor] = [.red, .orange] {
        didSet {
            indicatorLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    public var type: DisplayType = .none {
        didSet {
            update(by: type)
        }
    }
    
    // MARK: - private access property
    private var contentView: ContentView!
    
    private let borderWidth: CGFloat = 4
    
    private let intermediateLayer: CAShapeLayer! = .init()
    
    private let indicatorLayer: CAGradientLayer = .init()
    
    private let rotateAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: KeyPath.rotation)
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.speed = 0.0
        animation.repeatCount = .infinity
        return animation
    }()
    
    // MARK: - Initializer
    public init(frame: CGRect, displayType: DisplayType, image: UIImage?, colors: [UIColor]) {
        super.init(frame: frame)
        configure(displayType: displayType, image: image, colors: colors)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        intermediateLayer.borderColor = UIColor.border.cgColor
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        // arrange layout
        configureLayout()
    }
    
    private func configure(displayType: DisplayType = .none, image: UIImage? = nil, colors: [UIColor] = [.red, .orange]) {
        configureView()
        configureLayer()
        configureLayout()
        configureRecognizer()
        
        layer.addSublayer(indicatorLayer)
        layer.addSublayer(intermediateLayer)
        addSubview(contentView)
        addSubview(statusView)
        
        update(by: displayType)
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

// Configuration
private extension IGStoryButton {
    func configureView() {
        contentView = .init(frame: CGRect(x: borderWidth / 2.0, y: borderWidth / 2.0, width: frame.width - borderWidth, height: frame.height - borderWidth))
        contentView.image = image
        statusView = .init(frame: CGRect(x: (frame.width - borderWidth) * 3.0 / 4.0, y: (frame.width - borderWidth) * 3.0 / 4.0, width: (frame.width - borderWidth) / 3.0, height: (frame.width - borderWidth) / 3.0))
    }
    
    func configureLayer() {
        indicatorLayer.colors = colors.map { $0.cgColor }
        intermediateLayer.borderColor = UIColor.border.cgColor
        intermediateLayer.borderWidth = borderWidth / 2.0
        intermediateLayer.backgroundColor = UIColor.black.cgColor
    }
    
    func configureLayout() {
        layer.cornerRadius = layer.frame.width / 2.0
        indicatorLayer.frame = contentView.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        indicatorLayer.cornerRadius = indicatorLayer.frame.width / 2.0
        intermediateLayer.frame = contentView.frame.insetBy(dx: -borderWidth / 2.0, dy: -borderWidth / 2.0)
        intermediateLayer.cornerRadius = intermediateLayer.frame.width / 2.0
        statusView.frame = CGRect(x: (frame.width - borderWidth) * 3.0 / 4.0, y: (frame.width - borderWidth) * 3.0 / 4.0, width: (frame.width - borderWidth) / 3.0, height: (frame.width - borderWidth) / 3.0)
    }
    
    /// configureRecognizer: GestureRecognizer configuration
    func configureRecognizer() {
        let tapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(didTapped))
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressed))
        addGestureRecognizer(tapGestureRecognizer)
        addGestureRecognizer(longPressGestureRecognizer)
    }
}

private extension IGStoryButton {
    @objc func didTapped(sender: UITapGestureRecognizer) {
        delegate?.didTapped()
    }
    
    @objc func didLongPressed(sender: UILongPressGestureRecognizer) {
        delegate?.didLongPressed()
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
    
    func update(by displayType: DisplayType) {
        switch displayType {
        case .seen:
            indicatorLayer.isHidden = false
            statusView.isHidden = true
            indicatorLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        case .unseen:
            indicatorLayer.isHidden = false
            statusView.isHidden = true
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .status(let type):
            indicatorLayer.isHidden = true
            statusView.isHidden = false
            switch type {
            case .color(let color):
                statusView.set(color: color)
            case .image(let image):
                statusView.set(image: image)
            }
        case .none:
            indicatorLayer.isHidden = true
            statusView.isHidden = true
        }
    }
}
