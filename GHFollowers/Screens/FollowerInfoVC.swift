//
//  FollowerInfoVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/10/24.
//  OG name = UserInfoVC

import UIKit

class FollowerInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        getFollowerInfo()
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemPink
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    //this doesn't need params b/c info isn't changing on the VC
    //you only ever see one user w/out mulitple pages of info, unlike FollowerListVC > getFollowers(username:, page)
    func getFollowerInfo() {
        NetworkManager.shared.getFollowerInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user.)
            }
        }
    }
    

  

}
