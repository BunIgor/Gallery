//
//  AlbumsTableViewController.swift
//  Gallery
//
//  Created by user on 6/28/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {
    
    private var albums = [Album]()
    private let showAlbumSegueName = "ShowAlbum"
    private var alertController: UIAlertController!
    private var albumId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AlbumService.fetchAlbums { [weak self] (albums) in
            self?.albums = albums
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAlbumSegueName, let photosController = segue.destination as? PhotosCollectionViewController {
                photosController.albumId = albumId
        }
    }
}

extension AlbumsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.className, for: indexPath) as? AlbumTableViewCell else { fatalError() }
        
        cell.setCell(albums[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        albumId = albums[indexPath.row].id
        performSegue(withIdentifier: showAlbumSegueName, sender: self)
    }
}
