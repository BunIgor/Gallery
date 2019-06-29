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
    
    func setCell(_ photo: Photo) {
        
        guard let url = URL(string: photo.thumbnailUrl) else { return }
        do {
            let data =  try Data(contentsOf: url)
            imageView.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
        titleLabel.text = photo.title
    }
}
