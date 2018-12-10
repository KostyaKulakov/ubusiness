//
//  PhoneVerificationTextFieldDelegate.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import UIKit

class PhoneVerificationTextFieldDelegate: UITextField {
    var generalView: PhoneVerificationViewController?
    
    override func deleteBackward() {
        super.deleteBackward()
        
        let previousTag = self.tag - 1
        if let previousResponder = self.superview?.viewWithTag(previousTag) {
            previousResponder.becomeFirstResponder()
            
            if let previousTextField = previousResponder as? UITextField {
                previousTextField.text = ""
            }
        }
    }

}

extension PhoneVerificationTextFieldDelegate: UITextFieldDelegate {
    
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
        print("\(textFieldCount) \(string.count) \(textField.text)")
        if textFieldCount < 1 && string.count > 0 {
            
            setValueAndMoveForward()
            
            if textField.tag == 4 {
                generalView?.performToControlPanel()
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
