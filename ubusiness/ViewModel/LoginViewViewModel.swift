//
//  LoginViewViewModel.swift
//  ubusiness
//
//  Created by Константин Кулаков on 09.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation
import UIKit

class LoginViewViewModel {
    func frameResizeWithKeyboard(notification: Notification, with view: UIView, buttonJoinBottomConstraint: NSLayoutConstraint, logoTopConstraint: NSLayoutConstraint, isShowEvent: Bool) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if isShowEvent {
                if view.frame.origin.y == 0 {
                    buttonJoinBottomConstraintOld = buttonJoinBottomConstraint.constant
                    buttonJoinBottomConstraint.constant = 20
                    logoTopConstraint.constant /= 3
                    view.frame.origin.y -= keyboardSize.height
                    view.layoutIfNeeded()
                }
            } else {
                if view.frame.origin.y != 0 {
                    if let buttonJoinBottomConstraintOld = buttonJoinBottomConstraintOld {
                        buttonJoinBottomConstraint.constant = buttonJoinBottomConstraintOld
                    }
                    logoTopConstraint.constant *= 3
                    view.frame.origin.y += keyboardSize.height
                    view.layoutIfNeeded()
                }
            }
        }
    }
    
    private var buttonJoinBottomConstraintOld: CGFloat?
}
