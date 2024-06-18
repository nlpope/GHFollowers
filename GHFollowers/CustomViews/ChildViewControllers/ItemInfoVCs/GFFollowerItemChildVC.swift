//
//  GFFollowerItemChildVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/17/24.
//

import UIKit

class GFFollowerItemChildVC: GFItemInfoSuperVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitFollowers(for: self.user)
    }
}
