//
//  LoginViewPhoneFieldViewModel.swift
//  ubusiness
//
//  Created by Константин Кулаков on 09.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

class LoginViewPhoneFieldViewModel {
    func formattedPhoneNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var mask = "+X (XXX) XXX XX-XX"
        
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask.characters {
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
        
        // App for Russian SIM only
        if result.range(of: "+7") == nil && result.count > 1 {
            result = replace(myString: result, 1, "7")
        }
        
        return result
    }
    
    private func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString.characters)
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    func isCorrectNumber() -> Bool {
        let mask = "+X (XXX) XXX XX-XX"
        return phoneString.count == mask.count
    }
    
    init(with phoneNumber: String) {
        self._phoneString = phoneNumber
    }
    
    private var _phoneString: String = ""
    
    var serverLikePhone: String {
        get {
            return self.phoneString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        }
    }
    var phoneString: String {
        get {
            return formattedPhoneNumber(number: self._phoneString)
        }
    }
}
