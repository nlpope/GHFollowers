//
//  FollowerInfoVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/10/24.
//  OG name = UserInfoVC

import UIKit

class FollowerInfoVC: UIViewController {
    
    let headerView = UIView()
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getFollowerInfo()
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //leadingAnchor/trailingAnchor constants padding handled in GFFollowerInfoHeaderChildVC (contained within)
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    
    //see note 3 in app delegate
    func getFollowerInfo() {
        NetworkManager.shared.getFollowerInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let follower):
                DispatchQueue.main.async { self.add(childVC: GFFollowerInfoHeaderChildVC(follower: follower), to: self.headerView) }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
