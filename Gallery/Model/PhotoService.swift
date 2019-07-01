//
//  PhotosService.swift
//  Gallery
//
//  Created by user on 7/1/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class PhotoService {
    static let path = "photos"
    
    static func fetchPhotos(albumId: Int, completion: @escaping (([Photo])->Void)) {
        NetworkManager.fetch(path: path) { (data) in
            do {
                var photos = try JSONDecoder().decode([Photo].self, from: data)
                photos = photos.filter({
                    $0.albumId == albumId
                })
                completion(photos)
            } catch {
                print("error: ",error.localizedDescription)
            }
        }
    }
}
