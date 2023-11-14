//
//  KeyboardObserving.swift
//  aiqfome
//
//  Created by Frédéric Helfer on 14/11/23.
//

import Foundation

import UIKit

@objc protocol KeyboardObserving {
    @objc func keyboardWillShow(notification: Notification)
    @objc func keyboardWillHide(notification: Notification)
}

extension KeyboardObserving where Self: UIViewController {

    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
