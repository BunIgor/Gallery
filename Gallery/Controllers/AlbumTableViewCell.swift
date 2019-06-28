//
//  AlbumTableViewCell.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet private weak var idAlbum: UILabel!
    @IBOutlet private weak var userId: UILabel!
    @IBOutlet private weak var title: UILabel!
    
    func setCell(_ album: Album) {
        idAlbum.text = "Album Id: " + String(album.id)
        userId.text = "User Id: " + String(album.userId)
        title.text = album.title
    }
}

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
