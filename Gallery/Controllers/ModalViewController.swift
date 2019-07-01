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
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
    
    func setImage(_ image: UIImage) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }
    
    @IBAction private func closeAction(_ sender: Any) {
        view.removeFromSuperview()
    }
}
