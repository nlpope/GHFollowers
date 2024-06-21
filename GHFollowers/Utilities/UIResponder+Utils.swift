//
//  UIResponder+Utils.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/20/24.
//

import UIKit

extension UIResponder {
    
    // MARK: KEYBOARD
    
    // see note 14 in app delegate
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    
    static func currentResponder() -> UIResponder? {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    
    
    @objc private func _trap() {
        Static.responder = self
    }
}
