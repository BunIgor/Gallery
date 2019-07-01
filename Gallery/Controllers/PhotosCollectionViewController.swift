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
        print(photo)
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.className, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError()
        }
        
        cell.setCell(photo[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpVCid") as! ModalViewController
        
        guard let url = URL(string: photo[indexPath.row].url) else { return }
        DispatchQueue.global().async {
            do {
                let data =  try Data(contentsOf: url)
                DispatchQueue.main.async {
                    popUpVC.setImage(UIImage(data: data)!)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        addChild(popUpVC)
        popUpVC.view.frame = view.frame
        view.addSubview(popUpVC.view)
        
        popUpVC.didMove(toParent: self)
    }
}
