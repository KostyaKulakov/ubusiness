//
//  ServerProtocol.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

protocol ServerApiProtocol {
    static func authByPhone(phone: String, completionHandler: @escaping (ServerAuthByPhoneModel?) -> Void)
    static func authByToken(token: String, completionHandler: @escaping (ServerAuthByTokenModel?) -> Void)
    static func sendCodeByToken(token: String, completionHandler: @escaping (ServerSendCodeByTokenModel?) -> Void)
    static func checkCodeByToken(token: String, code: String, completionHandler: @escaping (ServerCheckCodeByTokenModel?) -> Void)
    static func getUserByToken(token: String, completionHandler: @escaping (ServerGetUserByTokenModel?) -> Void)
}
