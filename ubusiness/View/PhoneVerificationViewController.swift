//
//  PhoneVerificationViewController.swift
//  ubusiness
//
//  Created by Константин Кулаков on 09.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import UIKit

class PhoneVerificationViewController: UIViewController {
    var clientPhoneNumber: String?
    
    @IBOutlet var phoneVerificationTextFields: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for textField in phoneVerificationTextFields {
            textField.keyboardType = UIKeyboardType.decimalPad
            textField.delegate = self
        }
        
        phoneVerificationTextFields[0].becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissKeyboard()
    }
    
    func performToControlPanel() {
        performSegue(withIdentifier: "segueToControlPanel", sender: self)
    }
    
    @IBAction func changedPhoneVerificationTextFields(_ sender: Any) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PhoneVerificationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldCount = textField.text?.count else { return false }
        
        // Сlosure
        let setValueAndMoveForward = {
            textField.text = string
            let nextTag = textField.tag + 1
            if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                nextResponder.becomeFirstResponder()
            }
        }
        
        // Сlosure
        let clearValueAndMoveBack = {
            textField.text = ""
            let previousTag = textField.tag - 1
            if let previousResponder = textField.superview?.viewWithTag(previousTag) {
                previousResponder.becomeFirstResponder()
            }
        }
        
        if textFieldCount < 1 && string.count > 0 {
            
            setValueAndMoveForward()
            
            if textField.tag == 4 {
                performToControlPanel()
            }
            
            return false
            
        } else if textFieldCount >= 1 && string.count == 0 {
            
            clearValueAndMoveBack()
            return false
            
        } else if textFieldCount >= 1 && string.count > 0 {
            
            let nextTag = textField.tag + 1
            if let previousResponder = textField.superview?.viewWithTag(nextTag) {
                previousResponder.becomeFirstResponder()
                
                if let activeTextField = previousResponder as? UITextField {
                    activeTextField.text = string
                }
            }
            
            return false
        }
        
        return true
        
    }
    
}
