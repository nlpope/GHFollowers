//
//  GFUserInfoHeaderChildVC.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/12/24.
//

import UIKit

class GFUserInfoHeaderChildVC: UIViewController {
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
        
    var follower: Follower!
    
    
    init(follower: Follower) {
        super.init(nibName: nil, bundle: nil)
        self.follower = follower
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
    }
    
    
    func addSubviews() {
        let subviews = [avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel]
        
        for subview in subviews {
            view.addSubview(subview)
        }
        
    }
    
    
    func layoutUI() {
        
    }
    


}
