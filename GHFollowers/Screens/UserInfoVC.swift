//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/10/24.
//

import UIKit

// see notes 24a & 24b in app delegate
protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    
    let headerView               = UIView()
    let itemViewOneContainer     = UIView()
    let itemViewTwoContainer     = UIView()
    let dateLabel                = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView]      = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationVC()
        layoutUI()
        getUserInfo()
    }
    
    
    private func configureNavigationVC() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    //see note 3 in app delegate
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
             
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                break
            }
        }
    }
    
    
    func configureUIElements(with user: User) {
        // see note 7 in app delegate
        self.add(childVC: GFRepoItemChildVC(user: user, delegate: self),
                 toContainer: self.itemViewOneContainer)
        self.add(childVC: GFFollowerItemChildVC(user: user, delegate: self),
                 toContainer: self.itemViewTwoContainer)
        self.add(childVC: GFUserInfoHeaderChildVC(user: user), toContainer: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    
    func add(childVC: UIViewController, toContainer containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
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
        
        // see note 23 in app delegate
            
        NSLayoutConstraint.activate([
            //see note 4 in app delegate
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOneContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOneContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwoContainer.topAnchor.constraint(equalTo: itemViewOneContainer.bottomAnchor, constant: padding),
            itemViewTwoContainer.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwoContainer.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}


// MARK: DELEGATE METHODS
extension UserInfoVC: GFRepoItemChildVCDelegate, GFFollowerItemChildVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)        
    }
    
    
    func didTapGitFollowers(for user: User) {
        guard user.followers != 0 else { 
            presentGFAlertOnMainThread(alertTitle: "No followers", message: "This user has no followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
