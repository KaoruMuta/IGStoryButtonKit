//
//  StatusView.swift
//  IGStoryUI
//
//  Created by k_muta on 2021/01/03.
//

import UIKit

final public class StatusView: UIImageView {
    
    init(frame: CGRect, image: UIImage? = nil) {
        super.init(frame: frame)
        self.image = image
        layer.cornerRadius = frame.width / 2.0
        layer.borderWidth = frame.width / 6.0
        layer.borderColor = UIColor.border.cgColor
        clipsToBounds = true
        backgroundColor = .green
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
