//
//  PhotoCollectionViewCell.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setCell(_ photo: Photo) {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        guard let url = URL(string: photo.thumbnailUrl) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.imageView.image = UIImage(data: data)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        titleLabel.text = photo.title
    }
}
