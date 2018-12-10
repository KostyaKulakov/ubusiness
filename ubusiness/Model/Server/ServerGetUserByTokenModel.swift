//
//  ServerGetUserByTokenModel.swift
//  ubusiness
//
//  Created by Константин Кулаков on 11.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

struct ServerGetUserByTokenModel: ServerAlwaysAnswerProtocol {
    var code: Int
    var token: String
    var phone: String
    var firstname: String
    var patronymic: String
    var status: String
}
