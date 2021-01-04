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
    }
    
    func configure(displayType: IGStoryButton.DisplayType, image: UIImage?, text: String) {
        storyButton.type = displayType
        storyButton.image = image
        descriptionLabel.text = text
    }
}
