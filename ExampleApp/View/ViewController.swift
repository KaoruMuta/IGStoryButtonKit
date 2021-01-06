//
//  ViewController.swift
//  ExampleApp
//
//  Created by k_muta on 2020/12/31.
//

import UIKit
import IGStoryButtonKit

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
    
    private var models: [Story] = []
    private var displayTypes: [IGStoryButton.DisplayType] = []
    private var images: [UIImage?] = []
    private var descriptions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        models = [
            .init(image: UIImage(named: "ramen"), displayType: .seen, colorType: .black, description: "seen"),
            .init(image: UIImage(named: "ramen"), displayType: .unseen, colorType: .default, description: "unseen"),
            .init(image: UIImage(named: "ramen"), displayType: .status(type: .color(of: .green)), colorType: .clear, description: "status (color)"),
            .init(image: UIImage(named: "ramen"), displayType: .status(type: .image(of: UIImage(named: "ramen"))), colorType: .clear, description: "status (image)"),
            .init(image: UIImage(named: "ramen"), displayType: .none, colorType: .clear, description: "none"),
        ]
        
        setUI()
    }
    
    private func setUI() {
        let button: IGStoryButton = {
            let button = IGStoryButton()
            button.frame = CGRect(origin: CGPoint(x: view.center.x - 50 / 2.0, y: view.center.y - 50 / 2.0), size: CGSize(width: 50, height: 50))
            button.image = UIImage(named: "ramen")
            button.condition = .init(display: .status(type: .color(of: .green)), color: .custom(colors: [.cyan, .yellow, .gray]))
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
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? StoryCell else { return UICollectionViewCell() }
        cell.configure(with: models[indexPath.row])
        return cell
    }
}

