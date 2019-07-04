//
//  PhotosCollectionViewController.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit


class PhotosCollectionViewController: UICollectionViewController {
    
    var photos = [Photo]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    var albumId: Int! {
        didSet {
            PhotoService.fetchPhotos(albumId: albumId) { (photos) in
                self.photos = photos
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.className, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError()
        }
        
        cell.setCell(photos[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ModalViewController.className) as! ModalViewController
        
        popUpVC.urlImage = photos[indexPath.row].url
        present(popUpVC, animated: true, completion: nil)
    }
}
