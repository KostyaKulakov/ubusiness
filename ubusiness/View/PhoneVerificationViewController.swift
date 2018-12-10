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
    
    @IBOutlet var phoneVerificationTextFields: [PhoneVerificationTextFieldDelegate]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for textField in phoneVerificationTextFields {
            textField.keyboardType = UIKeyboardType.decimalPad
            textField.delegate = textField as UITextFieldDelegate
            textField.generalView = self
        }
        
        phoneVerificationTextFields[0].becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dismissKeyboard()
    }
    
    func performToControlPanel() {
        let code =  phoneVerificationTextFields[0].text! +
                    phoneVerificationTextFields[1].text! +
                    phoneVerificationTextFields[2].text! +
                    phoneVerificationTextFields[3].text!;
        
        UserSerivce.current.toVeryfiUser(code: code) { (isSuccess: Bool) in
            if isSuccess {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "segueToControlPanel", sender: self)
                }
            }
        }
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
