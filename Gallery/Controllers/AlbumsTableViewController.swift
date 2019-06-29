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
    private var photos = [Photo]()
    private let showAlbumSegueName = "ShowAlbum"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbums()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAlbumSegueName {
            guard let PhotosController = segue.destination as? PhotosCollectionViewController else { return }
            fetchPhotos()
            PhotosController.setPhoto(self.photos)
        }
    }
    
    private func fetchPhotos(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            return
        }
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.photos = try JSONDecoder().decode([Photo].self, from: data)
                semaphore.signal()
            } catch {
                print("error: ",error.localizedDescription)
            }
            }.resume()
        semaphore.wait()
    }
    
    private func fetchAlbums() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                return
            }
            
            do {
                self.albums = try JSONDecoder().decode([Album].self, from: data)
                self.albums = self.albums.sorted{$0.title < $1.title}
                self.albums = self.albums.map(){
                    Album(userId: $0.userId, id: $0.id, title: $0.title.prefix(1).uppercased() + $0.title.dropFirst())
                }
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            } catch {
                print("error: ",error.localizedDescription)
            }
        }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.className, for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        cell.setCell(albums[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showAlbumSegueName, sender: self)
    }
}
