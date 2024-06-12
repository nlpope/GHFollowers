//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/28/24.
//

import UIKit

class GFAlertContainerView: UIView {
        
    //set up background, corner, border, autoresizing here (the UIView), then constraints in the view controller it's to be used in
    //let containerView = UIView(): unnecessary, use the raw values like "layer" instead of prefacing with 'view' (UIViews have no access to 'view') - see GFButton
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configure() {
       backgroundColor                           = .systemBackground
       layer.cornerRadius                        = 16
       layer.borderWidth                         = 2
       layer.borderColor                         = UIColor.white.cgColor
       translatesAutoresizingMaskIntoConstraints = false
    }
}
