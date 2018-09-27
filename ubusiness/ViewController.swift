//
//  ViewController.swift
//  ubusiness
//
//  Created by Константин Кулаков on 27.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var aspectLogoConstraint: NSLayoutConstraint!
    
    static var  defaultBottomConstraintValue,
                defaultTopLogoConstraintValue: CGFloat?
    
    // QA: it's normal?
    //var bottomConstraintValue: CGFloat // for work keyboard handler
    
    @objc func flexContentFromBoard(notification:NSNotification, showKeyBoard:Bool) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        // QA: How made normal it?
        if ViewController.defaultBottomConstraintValue == nil &&
            ViewController.defaultTopLogoConstraintValue == nil {
            
            ViewController.defaultBottomConstraintValue = self.bottomConstraint.constant
            ViewController.defaultTopLogoConstraintValue = self.topLogoConstraint.constant
        }
        
        if  let bottomConstraintValue = ViewController.defaultBottomConstraintValue,
            let topLogoConstraintValue = ViewController.defaultTopLogoConstraintValue {
            let keyboardHeight: CGFloat = keyboardFrame.size.height
            
            // QA: Why it call warring?
            //let _currentHeight = currentBottomContraintValue + keyboardHeight
            
            self.bottomConstraint.constant = bottomConstraintValue + (showKeyBoard ? keyboardHeight : 0)
            
            if(showKeyBoard) {
                self.topLogoConstraint.constant = topLogoConstraintValue / 2
                
            } else {
                self.topLogoConstraint.constant = topLogoConstraintValue
            }
            
            // Why 3 call function, when keyboard show
            print("Event: \(showKeyBoard) \(self.bottomConstraint.constant) \(keyboardHeight) TLC \(topLogoConstraintValue)")
        }

    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        flexContentFromBoard(notification: notification, showKeyBoard: true)
    }
    
    @objc func keyboardWillHide(notification:NSNotification) {
        flexContentFromBoard(notification: notification, showKeyBoard: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add listner handler for keyboard event
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Hide keyboard if click from empty space
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

