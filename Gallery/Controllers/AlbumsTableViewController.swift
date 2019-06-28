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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAlbums()

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
}
