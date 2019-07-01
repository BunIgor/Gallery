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
        if segue.identifier == showAlbumSegueName {
            guard let PhotosController = segue.destination as? PhotosCollectionViewController else { return }
            PhotoService.fetchPhotos(albumId: albumId) { (photos) in
                PhotosController.setPhoto(photos)
            }
        }
    }
    
    private func showAlert() {
        alertController = UIAlertController(title: "Please wait...", message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(frame: alertController.view.bounds)
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        alertController.view.addSubview(activityIndicator)
        present(alertController, animated: true, completion: nil)
        activityIndicator.startAnimating()
    }
    
    private func closeAlert() {
        alertController.dismiss(animated: true, completion: nil)
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
        self.performSegue(withIdentifier: self.showAlbumSegueName, sender: self)
    }
}
