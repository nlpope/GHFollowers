//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/10/24.
//  OG name = UserInfoVC

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView               = UIView()
    let itemViewOneContainer     = UIView()
    let itemViewTwoContainer     = UIView()
    let dateLabel                = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView]      = []
    
    var username: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        getUserInfo()
    }
    
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOneContainer, itemViewTwoContainer, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
//        itemViewOneContainer.backgroundColor = .systemPink
//        itemViewTwoContainer.backgroundColor = .systemBlue
            
        NSLayoutConstraint.activate([
            //see note 4 in app delegate
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOneContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOneContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwoContainer.topAnchor.constraint(equalTo: itemViewOneContainer.bottomAnchor, constant: padding),
            itemViewTwoContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwoContainer.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
            
        ])
        
    }
    
    
    //see note 3 in app delegate
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderChildVC(user: user), toContainer: self.headerView)
                    self.add(childVC: GFRepoItemChildVC(user: user), toContainer: self.itemViewOneContainer)
                    self.add(childVC: GFFollowerItemChildVC(user: user), toContainer: self.itemViewTwoContainer)
                    self.dateLabel.text = user.createdAt
                    
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    
    func add(childVC: UIViewController, toContainer containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
