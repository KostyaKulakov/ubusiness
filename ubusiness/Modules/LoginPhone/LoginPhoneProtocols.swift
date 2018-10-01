//
//  LoginPhoneProtocols.swift
//  ubusiness
//
//  Created by Константин Кулаков on 30.09.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation
import UIKit

protocol LoginPhoneViewProtocol: class {
}

protocol LoginPhonePresenterProtocol: class {
    func configureView()
}

protocol LoginPhoneInteractorProtocol: class {
}

protocol LoginPhoneRouterProtocol: class {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

protocol LoginPhoneConfiguratorProtocol: class {
    func configure(with viewController: LoginPhoneViewController)
}
