//
//  UIResponder+Utils.swift
//  GHFollowers
//
//  Created by Noah Pope on 6/20/24.
//

import UIKit

extension UIResponder
{
    
    // MARK: KEYBOARD
    private struct Static
    {
        static weak var responder: UIResponder?
    }
    
    
    // determines which element onscreen triggered the keyboard
    static func currentResponder() -> UIResponder?
    {
        Static.responder = nil
        UIApplication.shared.sendAction(#selector(UIResponder._trap),
                                        to: nil,
                                        from: nil,
                                        for: nil)
        return Static.responder
    }
    
    
    @objc private func _trap() { Static.responder = self }
}
