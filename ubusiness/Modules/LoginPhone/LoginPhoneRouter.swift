//
//  LoginPhoneRouter.swift
//  ubusiness
//
//  Created by Константин Кулаков on 30.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation
import UIKit

class LoginPhoneRouter: LoginPhoneRouterProtocol {
    
    weak var viewController: LoginPhoneViewController!
    
    init(viewController: LoginPhoneViewController) {
        self.viewController = viewController
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare here some data for destination viewController
    }
}
