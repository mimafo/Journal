//
//  KeyboardScrollable.swift
//  Journal
//
//  Created by Michael Folcher on 11/4/18.
//  Copyright © 2018 Mimafo. All rights reserved.
//

import UIKit

@objc protocol KeyboardScrollable {
    
    func getScrollView() -> UIScrollView?
    
    @objc func keyboardDidShow(_ notification: Notification)
    @objc func keyboardWillHide(_ notification: Notification)

}

extension KeyboardScrollable where Self: UIViewController {
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(_ notification: Notification) {
        guard let info = notification.userInfo,
              let kbValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let kbSize = kbValue.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        if let scrollView = getScrollView() {
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillBeHidden(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        if let scrollView = getScrollView() {
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
}
