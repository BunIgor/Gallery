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
        let params = ["albumId":"\(albumId)"]
        NetworkManager.fetch(path: path, params: params) { (data) in
            do {
                let photos = try JSONDecoder().decode([Photo].self, from: data)

                completion(photos)
            } catch {
                print("error: ",error.localizedDescription)
            }
        }
    }
}
