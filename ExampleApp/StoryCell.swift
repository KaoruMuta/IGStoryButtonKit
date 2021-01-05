//
//  StoryCell.swift
//  ExampleApp
//
//  Created by k_muta on 2021/01/04.
//

import UIKit
import IGStoryUI

class StoryCell: UICollectionViewCell {
    
    @IBOutlet private weak var storyButton: IGStoryButton!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        storyButton.delegate = self
        storyButton.addTarget(self, action: #selector(didTapped), for: .touchUpInside)
    }
    
    func configure(with model: Story) {
        storyButton.displayType = model.displayType
        storyButton.image = model.image
        descriptionLabel.text = model.description
    }
    
    @objc func didTapped() {
        switch storyButton.displayType {
        case .seen:
            storyButton.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.storyButton.stopAnimating()
            }
        case .unseen:
            storyButton.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.storyButton.displayType = .seen
                self?.storyButton.stopAnimating()
            }
        case .status, .none:
            break
        }
        
    }
}


extension StoryCell: IGStoryButtonDelegate {
    func didLongPressed() {
        print("Detect long press event via delegate!")
    }
}
