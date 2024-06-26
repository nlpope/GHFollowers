//
//  GFAlertContainerView.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/28/24.
//

import UIKit

class GFAlertContainerView: UIView {
        
 // see note 26 in app delegate
    
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
