//
//  LoginPhoneConfigurator.swift
//  ubusiness
//
//  Created by Константин Кулаков on 30.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation
import UIKit

class LoginPhoneConfigurator: LoginPhoneConfiguratorProtocol {
    
    func configure(with viewController: LoginPhoneViewController) {
        let presenter = LoginPhonePresenter(view: viewController)
        let interactor = LoginPhoneInteractor(presenter: presenter)
        let router = LoginPhoneRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
