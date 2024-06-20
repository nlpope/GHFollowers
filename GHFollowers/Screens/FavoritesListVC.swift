//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/24/24.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView               = UITableView()
    var favorites: [Follower]   = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationVC()
        getFavorites()
        
    }
    
    
    func configureNavigationVC() {
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame         = view.bounds
        // see note 10 in app delegate
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                
            case .failure(let error):
                break
            }
        }
    }
}


extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        
        cell.set(favorite: favorite)
        
        return cell
    }
    
    
}
