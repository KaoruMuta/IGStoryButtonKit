//
//  ViewController.swift
//  ExampleApp
//
//  Created by k_muta on 2020/12/31.
//

import UIKit
import IGStoryUI

class ViewController: UIViewController {
    
    @IBOutlet private weak var storyButton: IGStoryButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storyButton.backgroundColor = .clear
        storyButton.colors = [.yellow, .cyan, .black]
        storyButton.image = UIImage(named: "ramen")
        storyButton.addTarget(self, action: #selector(didTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        storyButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.storyButton.stopAnimating()
        }
    }
    
    @objc private func didTapped() {
        print("didTapped")
    }
}

