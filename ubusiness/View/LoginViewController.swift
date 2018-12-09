//
//  LoginViewController.swift
//  ubusiness
//
//  Created by Константин Кулаков on 07.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonJoinBottomConstraint: NSLayoutConstraint!
    var buttonJoinBottomConstraintOld: CGFloat?
    
    private var viewModel: LoginViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.phoneField.keyboardType = UIKeyboardType.decimalPad
        self.hideKeyboardWhenTappedAround()
        
        viewModel = LoginViewViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        viewModel?.frameResizeWithKeyboard(notification: notification, with: self.view, buttonJoinBottomConstraint: buttonJoinBottomConstraint, logoTopConstraint: logoTopConstraint, isShowEvent: true)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        viewModel?.frameResizeWithKeyboard(notification: notification, with: self.view, buttonJoinBottomConstraint: buttonJoinBottomConstraint, logoTopConstraint: logoTopConstraint, isShowEvent: false)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
