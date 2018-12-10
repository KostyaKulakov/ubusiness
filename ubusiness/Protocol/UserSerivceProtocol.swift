//
//  UserSerivceProtocol.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

protocol UserServiceProtocol {
    // Load user by Token. All operation by Token
    func loadUser(completionHandler: @escaping (Bool) -> Void)
    func login(completionHandler: @escaping (Bool) -> Void)
    func logout(completionHandler: @escaping (Bool) -> Void)
    func toVeryfiUser(code: String, completionHandler: @escaping (Bool) -> Void)
    
    // Tokens operation. All operation without Token
    func setToken(token: String)
    func isValidToken(completionHandler: @escaping (Bool) -> Void)
    func phoneAuth(by phone: String, completionHandler: @escaping (Bool) -> Void)
    
    // Overall operation
    func overallLogin(by token: String, completionHandler: @escaping (Bool) -> Void)
}
