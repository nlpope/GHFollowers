//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/31/24.
//

import Foundation

class NetworkManager {
    static let shared   = NetworkManager()
    let baseURL         = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //handle error, response, and data in that order
            if let _ =  error {
                //aka: "if the error exists"
                completed(nil, "Unable to complete your request. Please check your internet connection")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "invalid response from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
            } catch {
                
            }
        }
        
        task.resume()
    }
}
