//
//  IGStoryButton.swift
//  IGStoryButtonKit
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
    // MARK: - public access DataType
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
    
    public enum ColorType {
        case `default`
        case black
        case green
        case clear
        case custom(colors: [UIColor])
    }
    
    public struct TypeCondition {
        var color: ColorType
        var display: DisplayType
        
        public init(color: ColorType, display: DisplayType) {
            self.color = color
            self.display = display
        }
    }
    
    // MARK: - public access property
    public weak var delegate: IGStoryButtonDelegate?
    
    public var statusView: StatusView!
    
    public var image: UIImage? {
        didSet {
            contentView.image = image
        }
    }
    
    public var condition: TypeCondition = .init(color: .default, display: .none) {
        didSet {
            update(by: condition.display)
            update(by: condition.color)
        }
    }
    
    public var colorType: ColorType {
        condition.color
    }
    
    public var displayType: DisplayType {
        condition.display
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
    public init(frame: CGRect, displayType: DisplayType, colorType: ColorType, image: UIImage?) {
        super.init(frame: frame)
        configure(displayType: displayType, colorType: colorType, image: image)
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
        assert(frame.width == frame.height, "The size of width and height are required to be equal")
        // arrange layout
        configureLayout()
    }
    
    private func configure(displayType: DisplayType = .none, colorType: ColorType = .default, image: UIImage? = nil) {
        configureView()
        configureLayer()
        configureLayout()
        configureRecognizer()
        
        contentView.image = image
        layer.addSublayer(indicatorLayer)
        layer.addSublayer(intermediateLayer)
        addSubview(contentView)
        addSubview(statusView)
        
        update(by: displayType)
        update(by: colorType)
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
        statusView = .init(frame: CGRect(x: (frame.width - borderWidth) * 3.0 / 4.0, y: (frame.width - borderWidth) * 3.0 / 4.0, width: (frame.width - borderWidth) / 3.0, height: (frame.width - borderWidth) / 3.0))
    }
    
    func configureLayer() {
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
            // HACK: perform animation
            UIView.animate(withDuration: Parameter.duration, animations: {
                print("animation starting")
            }) { [weak self] _ in
                self?.transform = scaledTransform
                UIView.animate(withDuration: Parameter.duration, animations: { [weak self] in
                    self?.transform = .identity
                })
            }
        }
    }
    
    func update(by colorType: ColorType) {
        switch colorType {
        case .default:
            let colors = Color.pink
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .black:
            let colors = Color.black
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .green:
            let colors = Color.green
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .clear:
            let colors = Color.clear
            indicatorLayer.colors = colors.map { $0.cgColor }
        case .custom(let colors):
            indicatorLayer.colors = colors.map { $0.cgColor }
        }
    }
    
    func update(by displayType: DisplayType) {
        switch displayType {
        case .seen:
            update(by: .black)
            statusView.isHidden = true
        case .unseen:
            update(by: .default)
            statusView.isHidden = true
        case .status(let type):
            update(by: .clear)
            statusView.isHidden = false
            switch type {
            case .color(let color):
                statusView.set(color: color)
            case .image(let image):
                statusView.set(image: image)
            }
        case .none:
            update(by: .clear)
            statusView.isHidden = true
        }
    }
}
