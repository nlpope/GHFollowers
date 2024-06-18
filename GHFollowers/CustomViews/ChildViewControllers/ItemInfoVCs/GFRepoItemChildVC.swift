//
//  GFRepoItemChildVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/15/24.
//

import UIKit

class GFRepoItemChildVC: GFItemInfoSuperVC {
    
    //though init(user:) is not here, it is still necessary for the SuperVC
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
        delegate.didTapGitHubProfile(for: self.user)
    }
}
