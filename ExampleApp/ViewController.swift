//
//  ViewController.swift
//  ExampleApp
//
//  Created by k_muta on 2020/12/31.
//

import UIKit
import IGStoryUI

class ViewController: UIViewController {
    
    @IBOutlet private weak var storyView: IGStoryView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        storyView.backgroundColor = .clear
        storyView.image = UIImage(named: "ramen")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        storyView.startLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.storyView.stopLoading()
        }
    }
}

