//
//  ViewController.swift
//  Weather
//
//  Created by Владислав Колундаев on 26.07.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    private let notification = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEnd = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEnd, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.verticalScrollIndicatorInsets = scrollView.contentInset
        scrollView.horizontalScrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
}

