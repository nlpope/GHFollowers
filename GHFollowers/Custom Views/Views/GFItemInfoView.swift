//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/15/24.
//

import UIKit

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        //.scalenASpectFill aligns image views that are shapped differently
        //..e.g. hearts & folders won't be misaligned
        symbolImageView.contentMode = .scaleAspectFill
    }
}
