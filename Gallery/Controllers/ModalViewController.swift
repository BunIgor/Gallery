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
    
    var urlImage: String! {
        didSet {
            guard let url = URL(string: urlImage) else { return }
            DispatchQueue.global().async {
                do {
                    let data =  try Data(contentsOf: url)
                    DispatchQueue.main.async { [weak self] in
                        self?.setImage(UIImage(data: data)!)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.startAnimating()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setImage(_ image: UIImage) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }
    
    @objc private func handleTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !imageView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}
