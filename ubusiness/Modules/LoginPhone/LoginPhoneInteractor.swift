//
//  LoginPhoneInteractor.swift
//  ubusiness
//
//  Created by Константин Кулаков on 30.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

class LoginPhoneInteractor: LoginPhoneInteractorProtocol {
    
    weak var presenter: LoginPhonePresenterProtocol!
    
    required init(presenter: LoginPhonePresenterProtocol) {
        self.presenter = presenter
    }
    
}
