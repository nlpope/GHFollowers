//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/19/24.
//

import Foundation

//see note 8 in app delegate
enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
    }
}
