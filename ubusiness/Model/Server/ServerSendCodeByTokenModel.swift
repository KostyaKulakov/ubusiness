//
//  ServerSendCodeByTokenModel.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

struct ServerSendCodeByTokenModel: ServerAlwaysAnswerProtocol {
    var code: Int
    var token: String
    var status: String
    var loginAttempts: Int
}
