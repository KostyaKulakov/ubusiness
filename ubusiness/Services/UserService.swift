//
//  UserService.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

class UserSerivce: UserServiceProtocol {
    static let current = UserSerivce()
    private var user: UserModel?
    private var token: String?
    
    func loadUser(completionHandler: @escaping (Bool) -> Void) {
        guard let token = self.token
            else {
                completionHandler(false)
                return
        }
        
        Server.getUserByToken(token: token) { (getUserByTokenModel: ServerGetUserByTokenModel?) in
            guard let getUserByTokenModel = getUserByTokenModel
                else {
                    completionHandler(false)
                    return
            }
            
            self.user = UserModel(firstname: getUserByTokenModel.firstname,
                                  patronymic: getUserByTokenModel.patronymic,
                                  phone: getUserByTokenModel.phone,
                                  status: getUserByTokenModel.status)
            
            completionHandler(true)
        }
    }
    
    func login(completionHandler: @escaping (Bool) -> Void) {
        guard let token = self.token
            else {
                completionHandler(false)
                return
        }
        
        Server.authByToken(token: token) { (authByTokenModel: ServerAuthByTokenModel?) in
            guard let authByTokenModel = authByTokenModel
                else {
                    completionHandler(false)
                    return
            }
            
            completionHandler(authByTokenModel.code == 200)
            
            self.loadUser(completionHandler: { (isSuccess: Bool) in
                completionHandler(isSuccess)
                return
            })
        }
    }
    
    func logout(completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    func toVeryfiUser(code: String, completionHandler: @escaping (Bool) -> Void) {
        guard let token = self.token
            else {
                completionHandler(false)
                return
        }
        
        Server.checkCodeByToken(token: token, code: code) { (serverCheckCodeByToken: ServerCheckCodeByTokenModel?) in
            guard let serverCheckCodeByTokenModel = serverCheckCodeByToken
                else {
                    print("serverCheckCodeByToken is nil")
                    completionHandler(false)
                    return
            }
            
            completionHandler(serverCheckCodeByTokenModel.code == 200)
        }
    }
    
    func setToken(token: String) {
        self.token = token
    }
    
    func isValidToken(completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    func phoneAuth(by phone: String, completionHandler: @escaping (Bool) -> Void) {
        Server.authByPhone(phone: phone) { (authByPhoneModel: ServerAuthByPhoneModel?) in
            guard let authByPhoneModel = authByPhoneModel
                else {
                    print("phoneAuth completionHandler 1: false")
                    completionHandler(false)
                    return
            }
            
            self.token = authByPhoneModel.token
            
            Server.sendCodeByToken(token: authByPhoneModel.token, completionHandler: { (serverSendCodeByToken: ServerSendCodeByTokenModel?) in
                guard let serverSendCodeByToken = serverSendCodeByToken
                    else {
                        print("phoneAuth completionHandler 2: false")
                        completionHandler(false)
                        return
                }
                
                print("phoneAuth completionHandler 3: \(serverSendCodeByToken)")
                completionHandler(serverSendCodeByToken.status == "sended")
            })
        }
    }
    
    func overallLogin(by token: String, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    func internalCheckTokenStatus() -> Bool {
        return token != nil
    }
}
