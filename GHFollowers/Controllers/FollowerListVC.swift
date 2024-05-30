//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/25/24.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true 
        
    }

}
