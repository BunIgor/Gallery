//
//  NetworkManager.swift
//  Gallery
//
//  Created by user on 7/1/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

class NetworkManager {
    static let domain = "https://jsonplaceholder.typicode.com/"
    
    static func fetch(path: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: domain+path) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            completion(data)
        }.resume()
    }
}
