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
    
    static func fetch(path: String, params: [String:String]?,failure: @escaping (Error) -> Void, success: @escaping (Data) -> Void) {
        
        var urlString = domain + path
        
        if let params = params, !params.isEmpty {
            urlString += "?"
            for (param, value) in params {
                urlString += param + "=" + value + "&"
            }
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                failure(error)
                return
            }
            guard let data = data else { return }
            success(data)
        }.resume()
    }
}
