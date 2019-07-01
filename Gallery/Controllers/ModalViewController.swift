//
//  ModalViewController.swift
//  Gallery
//
//  Created by user on 7/1/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    @IBAction private func closeAction(_ sender: Any) {
        view.removeFromSuperview()
    }
}
