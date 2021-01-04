//
//  ViewController.swift
//  ExampleApp
//
//  Created by k_muta on 2020/12/31.
//

import UIKit
import IGStoryUI

class ViewController: UIViewController {
    
    @IBOutlet private weak var storyGalleryView: UICollectionView! {
        didSet {
            storyGalleryView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            storyGalleryView.delegate = self
            storyGalleryView.dataSource = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            storyGalleryView.collectionViewLayout = layout
        }
    }
    
    private var displayTypes: [IGStoryButton.DisplayType] = []
    private var images: [UIImage?] = []
    private var descriptions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayTypes = [.seen, .unseen, .status(type: .color(of: .green)), .status(type: .image(of: UIImage(named: "ramen"))), .none]
        images = [UIImage(named: "ramen"), UIImage(named: "ramen"), UIImage(named: "ramen"), UIImage(named: "ramen"), UIImage(named: "ramen")]
        descriptions = ["seen", "unseen", "status (color)", "status (image)", "none"]
        
        setUI()
    }
    
    private func setUI() {
        let button: IGStoryButton = {
            let button = IGStoryButton()
            button.frame = CGRect(origin: CGPoint(x: view.center.x - 50 / 2.0, y: view.center.y - 50 / 2.0), size: CGSize(width: 50, height: 50))
            button.colors = [UIColor.cyan, UIColor.yellow, UIColor.gray]
            button.image = UIImage(named: "ramen")
            button.type = .status(type: .color(of: .green))
            return button
        }()
        view.addSubview(button)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? StoryCell else { return UICollectionViewCell() }
        cell.configure(displayType: displayTypes[indexPath.row], image: images[indexPath.row], text: descriptions[indexPath.row])
        return cell
    }
}

