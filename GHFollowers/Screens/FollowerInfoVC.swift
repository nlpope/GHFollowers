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
    
    //see note 3 in app delegate
    func getFollowerInfo() {
        NetworkManager.shared.getFollowerInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    

  

}
