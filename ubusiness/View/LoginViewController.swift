//
//  LoginViewController.swift
//  ubusiness
//
//  Created by Константин Кулаков on 07.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import UIKit
import UITextField_Shake

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonJoinBottomConstraint: NSLayoutConstraint!
    var buttonJoinBottomConstraintOld: CGFloat?
    
    private var viewModel: LoginViewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneField.keyboardType = UIKeyboardType.decimalPad
        self.hideKeyboardWhenTappedAround()
        
        viewModel = LoginViewViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        super.viewWillDisappear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        viewModel?.frameResizeWithKeyboard(notification: notification, with: self.view, buttonJoinBottomConstraint: buttonJoinBottomConstraint, logoTopConstraint: logoTopConstraint, isShowEvent: true)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        viewModel?.frameResizeWithKeyboard(notification: notification, with: self.view, buttonJoinBottomConstraint: buttonJoinBottomConstraint, logoTopConstraint: logoTopConstraint, isShowEvent: false)
    }
    
    @IBAction func pressLoginButton(_ sender: Any) {
        guard let viewModel = self.viewModel else { return }

        if(!viewModel.isCorrectPhoneNumber()) {
            phoneField.shake(5, withDelta: 5, speed: 0.1)
            return;
        }
        
        UserSerivce.current.phoneAuth(by: viewModel.getServerLikePhoneNumber()) { (isSuccess: Bool) in
            print("UserSerivce.current.phoneAuth: \(isSuccess)")
            if isSuccess {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToPhoneVerification", sender: self)
                }
            }
        }
    }
    
    @IBAction func valueChangedPhoneField(_ sender: Any) {
        if let phoneNumber = phoneField.text, let viewModel = self.viewModel {
            self.phoneField.text = viewModel.getFormatedPhoneNumber(phoneNumber: phoneNumber)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToPhoneVerification" {
            let destinationVC = segue.destination as? PhoneVerificationViewController
            guard let vc = destinationVC else { return }
            
            vc.clientPhoneNumber = viewModel?.getServerLikePhoneNumber()
        }
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
