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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(photo[indexPath.row])
        
        guard let url = URL(string: photo[indexPath.row].url) else { return }
        do {
            let data =  try Data(contentsOf: url)
            
            let modView = UIView(frame: CGRect(x: 0, y: 0, width: 600, height: 600))
            modView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            modView.center = view.center
            let imageView = UIImageView(frame: modView.bounds)
            modView.addSubview(imageView)
            //imageView.center = modView.center
            view.addSubview(modView)
            
            imageView.image = UIImage(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
