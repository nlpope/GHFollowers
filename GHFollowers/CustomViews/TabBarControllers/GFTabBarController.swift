//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/20/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        setUpVCs()
        setupKeyboardHiding()
    }
    
    
    func setUpVCs() { viewControllers = [createSearchNC(), createFavoritesNC()] }
    
    
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC         = FavoritesListVC()
        favoritesListVC.title       = "Favorites"
        favoritesListVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
}
