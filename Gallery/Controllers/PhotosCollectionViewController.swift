//
//  PhotosCollectionViewController.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UICollectionViewController {

    private var photo = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setPhoto(_ photo: [Photo]) {
        self.photo = photo
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.className, for: indexPath) as! PhotoCollectionViewCell
    
        cell.setCell(photo[indexPath.row])
    
        return cell
    }
    
    
}
