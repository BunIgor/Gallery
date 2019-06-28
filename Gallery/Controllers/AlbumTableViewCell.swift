//
//  AlbumTableViewCell.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var idAlbum: UILabel!
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var title: UILabel!
    
    func setCell(_ album: Album) {
        idAlbum.text = String(album.id)
        userId.text = String(album.userId)
        title.text = album.title
    }
}
