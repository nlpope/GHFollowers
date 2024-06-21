//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Noah Pope on 5/30/24.
//
//  swift not cocoa touch class

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
        
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertChildVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC                        = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    
    // MARK: KEYBOARD
    func setupKeyboardHiding() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        // get keyboard measurements & currently focused text field location
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              // see note 13 in app delegate
              let currentTextField = UIResponder.currentResponder() as? UITextField else { return }
        
        // check if keyboard top is above text field bottom (relative to superview)
        // see note 14 in app delegate
        let keyboardTopY        = keyboardFrame.cgRectValue.origin.y
        let textFieldBottomY    = currentTextField.frame.origin.y + currentTextField.frame.size.height
        
        // bump view up if so: moving up/left = negative val, moving down/right = positive val
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY   = currentTextField.frame.origin.y
            let newFrameY       = (textFieldTopY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
    }
    
    
    @objc func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y = 0
    }
}
