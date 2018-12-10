//
//  Server.swift
//  ubusiness
//
//  Created by Константин Кулаков on 10.12.2018.
//  Copyright © 2018 Константин Кулаков. All rights reserved.
//

import Foundation

class Server: ServerApiProtocol {
    static func authByPhone(phone: String, completionHandler: @escaping (ServerAuthByPhoneModel?) -> Void) {
        let url = URL(string: Server.serverUrl+"authByPhone/"+phone)

        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                //print(jsonResult)
                var authByPhoneModel = ServerAuthByPhoneModel(code: 0, token: "", isExist: false)
                if let code = (jsonResult["code"] as? Int) {
                    authByPhoneModel.code = code
                }
                if let token = (jsonResult["token"] as? String) {
                    authByPhoneModel.token = token
                }
                if let isExist = (jsonResult["is_exist"] as? Bool) {
                    authByPhoneModel.isExist = isExist
                }
                
                completionHandler(authByPhoneModel)
                
            } else {
                completionHandler(nil)
            }
        }).resume()
    }
    
    static func authByToken(token: String, completionHandler: @escaping (ServerAuthByTokenModel?) -> Void) {
        let _url = URL(string: Server.serverUrl+"authByToken/")
        
        guard let url = _url
            else {
                completionHandler(nil)
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "token="+token
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                //print(jsonResult)
                var authByTokenModel = ServerAuthByTokenModel(code: 0, token: "", status: "")
                if let code = (jsonResult["code"] as? Int) {
                    authByTokenModel.code = code
                }
                
                if let token = (jsonResult["token"] as? String) {
                    authByTokenModel.token = token
                }
                
                if let status = (jsonResult["status"] as? String) {
                    authByTokenModel.status = status
                }
                
                completionHandler(authByTokenModel)
                
            } else {
                completionHandler(nil)
            }
        }).resume()
    }
    
    static func sendCodeByToken(token: String, completionHandler: @escaping (ServerSendCodeByTokenModel?) -> Void) {
        let _url = URL(string: Server.serverUrl+"sendCodeByToken/")
        
        guard let url = _url
            else {
                completionHandler(nil)
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "token="+token
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                //print(jsonResult)
                var sendCodeByTokenModel = ServerSendCodeByTokenModel(code: 0, token: "", status: "", loginAttempts: 0)
                if let code = (jsonResult["code"] as? Int) {
                    sendCodeByTokenModel.code = code
                }
                
                if let token = (jsonResult["token"] as? String) {
                    sendCodeByTokenModel.token = token
                }
                
                if let status = (jsonResult["status"] as? String) {
                    sendCodeByTokenModel.status = status
                }
                
                if let loginAttempts = (jsonResult["loginAttempts"] as? Int) {
                    sendCodeByTokenModel.loginAttempts = loginAttempts
                }
                
                completionHandler(sendCodeByTokenModel)
                
            } else {
                completionHandler(nil)
            }
        }).resume()
    }
    
    static func checkCodeByToken(token: String, code: String, completionHandler: @escaping (ServerCheckCodeByTokenModel?) -> Void) {
        let _url = URL(string: Server.serverUrl+"checkCodeByToken/")
        
        guard let url = _url
            else {
                completionHandler(nil)
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "token="+token+"&code="+code;
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                //print(jsonResult)
                var checkCodeByTokenModel = ServerCheckCodeByTokenModel(code: 0, token: "", status: "")
                if let code = (jsonResult["code"] as? Int) {
                    checkCodeByTokenModel.code = code
                }
                
                if let token = (jsonResult["token"] as? String) {
                    checkCodeByTokenModel.token = token
                }
                
                if let status = (jsonResult["status"] as? String) {
                    checkCodeByTokenModel.status = status
                }
                
                completionHandler(checkCodeByTokenModel)
                
            } else {
                completionHandler(nil)
            }
        }).resume()
    }
    
    static func getUserByToken(token: String, completionHandler: @escaping (ServerGetUserByTokenModel?) -> Void) {
        let _url = URL(string: Server.serverUrl+"getUserByToken/")
        
        guard let url = _url
            else {
                completionHandler(nil)
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postString = "token="+token
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                //print(jsonResult)
                var getUserByTokenModel = ServerGetUserByTokenModel(code: 0, token: "", phone: "", firstname: "", patronymic: "", status: "")
                if let code = (jsonResult["code"] as? Int) {
                    getUserByTokenModel.code = code
                }
                
                if let token = (jsonResult["token"] as? String) {
                    getUserByTokenModel.token = token
                }
                
                if let status = (jsonResult["status"] as? String) {
                    getUserByTokenModel.status = status
                }
                
                if let phone = (jsonResult["phone"] as? String) {
                    getUserByTokenModel.phone = phone
                }
                
                if let firstname = (jsonResult["firstname"] as? String) {
                    getUserByTokenModel.firstname = firstname
                }
                
                if let patronymic = (jsonResult["patronymic"] as? String) {
                    getUserByTokenModel.patronymic = patronymic
                }
                
                completionHandler(getUserByTokenModel)
                
            } else {
                completionHandler(nil)
            }
        }).resume()
    }
    
    static private var serverUrl = "https://test.kostyakulakov.ru/app/api/v1/"
}
