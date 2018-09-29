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

extension String {
    mutating func replaceByIndex(_ index: Int, _ newChar: Character) {
        var chars = Array(self)
        chars[index] = newChar
        let modifiedString = String(chars)
        self = modifiedString
    }
    
    mutating func formattedPhoneNumber(mask: String) {
        let cleanPhoneNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        self = result
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var aspectLogoConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputPhoneNumber: UITextField!
    
    // QA: it's normal?
    //var bottomConstraintValue: CGFloat // for work keyboard handler
    
    @objc func keyboardHandler(notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        let keyboardHeight: CGFloat = keyboardFrame.size.height
        
        
        if  let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let kFrame = self.view?.convert(frame, to: nil),
            let kBounds = self.view?.bounds
             {
                let isShow = kBounds.intersects(kFrame)
                
                self.bottomConstraint.constant += isShow ? keyboardHeight : -keyboardHeight
                self.topLogoConstraint.constant *= isShow ? 1/2 : 2
        }
        
        print("Event: \(self.bottomConstraint.constant) \(keyboardHeight)")

    }
    
    @IBAction func chanageInputPhoneNumber(_ sender: Any) {
        if var phoneNumber = self.inputPhoneNumber.text {
            
            phoneNumber.formattedPhoneNumber(mask: "+X (XXX) XXX XX-XX")
            
            // App for Russian SIM only
            if phoneNumber.range(of: "+7") == nil && phoneNumber.count > 1 {
                phoneNumber.replaceByIndex(1, "7")
            }
            
            self.inputPhoneNumber.text = phoneNumber
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add listner handler for keyboard event
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHandler), name:NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // Hide keyboard if click from empty space
        self.hideKeyboardWhenTappedAround()
        
        self.inputPhoneNumber.keyboardType = UIKeyboardType.decimalPad
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

