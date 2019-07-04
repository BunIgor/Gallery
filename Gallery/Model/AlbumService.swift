//
//  AlbumService.swift
//  Gallery
//
//  Created by user on 7/1/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class AlbumService {
    static let path = "albums"
    
    static func fetchAlbums(completion: @escaping ([Album])->Void){
        NetworkManager.fetch(path: path, params: nil) { (data) in
            do {
                var albums = try JSONDecoder().decode([Album].self, from: data)
                albums = albums.sorted{$0.title < $1.title}
                albums = albums.map() {
                    Album(userId: $0.userId, id: $0.id, title: $0.title.prefix(1).uppercased() + $0.title.dropFirst())
                }
                completion(albums)
            } catch {
                print("error: ",error.localizedDescription)
            }
        }
        
    }
}
