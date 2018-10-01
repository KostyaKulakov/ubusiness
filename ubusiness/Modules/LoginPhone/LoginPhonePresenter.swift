//
//  LoginPhonePresenter.swift
//  ubusiness
//
//  Created by Константин Кулаков on 30.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation
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

class LoginPhonePresenter: LoginPhonePresenterProtocol {
    
    weak var view: LoginPhoneViewProtocol!
    var interactor: LoginPhoneInteractorProtocol!
    var router: LoginPhoneRouterProtocol!
    
    required init(view: LoginPhoneViewProtocol) {
        self.view = view
    }
    
    func configureView() {
    }
    
}
