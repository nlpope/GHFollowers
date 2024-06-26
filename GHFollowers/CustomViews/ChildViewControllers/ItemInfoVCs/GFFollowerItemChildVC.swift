//
//  GFFollowerItemChildVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/17/24.
//

import UIKit

protocol GFFollowerItemChildVCDelegate: AnyObject {
    func didTapGitFollowers(for user: User)
}

class GFFollowerItemChildVC: GFItemInfoSuperVC {
    
    weak var delegate: GFFollowerItemChildVCDelegate!
    
    init(user: User, delegate: GFFollowerItemChildVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGitFollowers(for: user)
    }
}
