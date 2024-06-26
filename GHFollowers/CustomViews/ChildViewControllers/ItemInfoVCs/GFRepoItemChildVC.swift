//
//  GFRepoItemChildVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/15/24.
//

import UIKit

protocol GFRepoItemChildVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemChildVC: GFItemInfoSuperVC {
    
    weak var delegate: GFRepoItemChildVCDelegate!
    
    init(user: User, delegate: GFRepoItemChildVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
