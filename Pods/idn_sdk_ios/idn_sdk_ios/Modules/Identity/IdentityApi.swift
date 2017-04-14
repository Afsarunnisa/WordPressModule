//
//  IdentityApi.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/21/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import SwiftyJSON

open class IdentityApi : NetworkApi {
    
    required public init() {
        super.init()
        setModuleName("identity")
        setRemoteApiClass(IdentityRemoteApi.self)
    }
    
    
    open func login(_ login : LoginModel,responseHandler: @escaping (NewMemberApiModel?, MessagesApiModel?, NSError?) -> ()) {
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        let apiContext : IdsIosApiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let clientCredentials = apiContext.getClientCredentials()
        let clientID : String = clientCredentials.object(forKey: "client_id") as! String
        
        login.clientID = clientID
        
        remoteAPI.login(login, completionHandler: {
            responseObject,statusCode, error in
            
            var newMemApiModel : NewMemberApiModel = NewMemberApiModel()
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                newMemApiModel = NewMemberApiModel(json : swiftyJsonVar)
                apiContext.setUserToken("identity", tokenApiModel: newMemApiModel.tokenApiModel)
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(newMemApiModel,messageApiModel, error)
        })
    }
    
    
    open func signUp(_ signUp : SignUpModel ,responseHandler: @escaping (NewMemberApiModel?, MessagesApiModel?, NSError?) -> ()) {
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        let apiContext : IdsIosApiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let clientCredentials = apiContext.getClientCredentials()
        let clientID : String = clientCredentials.object(forKey: "client_id") as! String
        signUp.clientID = clientID
        
        remoteAPI.signUp(signUp, completionHandler: {
            
            responseObject,statusCode, error in
            
            var newMemApiModel : NewMemberApiModel = NewMemberApiModel()
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                newMemApiModel = NewMemberApiModel(json : swiftyJsonVar)
                apiContext.setUserToken("identity", tokenApiModel: newMemApiModel.tokenApiModel)
                
            }else if(statusCode == 400){
                
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(newMemApiModel,messageApiModel, error)
        })
    }
    
    
    open func logout(_ responseHandler: @escaping (MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        remoteAPI.logOut { (responseObject,statusCode, error) in
            
            var msgApiModel : MessagesApiModel = MessagesApiModel()
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                msgApiModel = MessagesApiModel(json: swiftyJsonVar)
            }else if(statusCode == 400){
                msgApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                msgApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            
            responseHandler(msgApiModel, error)
        }
    }
    
    
    open func socialWebLogin(socialType : String,responseHandler: @escaping (AnyObject?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        remoteAPI.socialWebLogin(socialType: socialType, completionHandler: {
            responseObject,statusCode, error in
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(responseObject,messageApiModel, error)
        })
    }
    
    
    open func socialLogin(_ socialLoginDetails : Dictionary<String, Any>, socialType : String,responseHandler: @escaping (NewMemberApiModel?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        let apiContext : IdsIosApiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let clientCredentials = apiContext.getClientCredentials()
        let clientID : String = clientCredentials.object(forKey: "client_id") as! String
        
        let socialDetailsDict: Dictionary<String, AnyObject> = ["accessToken" : socialLoginDetails["accessToken"] as AnyObject, "expiresIn" : socialLoginDetails["expiresIn"] as AnyObject, "clientId":clientID as AnyObject]
        
        
        remoteAPI.socialLogin(socialDetailsDict, socialType: socialType, completionHandler: {
            
            responseObject,statusCode, error in
            
            var newMemApiModel : NewMemberApiModel = NewMemberApiModel()
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                newMemApiModel = NewMemberApiModel(json : swiftyJsonVar)
                apiContext.setUserToken("identity", tokenApiModel: newMemApiModel.tokenApiModel)
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(newMemApiModel,messageApiModel, error)
        })
    }
    
    open func getProfile(_ userID: String, responseHandler: @escaping (MemberApiModel?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        remoteAPI.getProfile(userID, completionHandler: {
            
            responseObject,statusCode, error in
            
            var memApiModel : MemberApiModel = MemberApiModel()
            var msgApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                memApiModel = MemberApiModel(json : swiftyJsonVar)
                
            }else if(statusCode == 400){
                msgApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                msgApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(memApiModel,msgApiModel, error)
        })
    }
    
    
    open func updateProfile(_ profileDict: Dictionary<String, Any>,userID: String, responseHandler: @escaping (MemberApiModel?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        remoteAPI.updateProfile(profileDict, userID: userID, completionHandler: {
            
            responseObject,statusCode, error in
            
            var memApiModel : MemberApiModel = MemberApiModel()
            var msgApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                memApiModel = MemberApiModel(json : swiftyJsonVar)
                
            }else if(statusCode == 400){
                msgApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                msgApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(memApiModel,msgApiModel, error)
        })
    }
    
    
    open func changePassword(_ passwordDict: Dictionary<String, Any>, responseHandler: @escaping (MessagesApiModel?, NSError?) -> ()){
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        remoteAPI.changePassword(passwordDict, completionHandler: {
            
            responseObject,statusCode, error in
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            
            responseHandler(messageApiModel, error)
        })
    }
    
    
    open func forgotPassword(_ passwordDict: Dictionary<String, Any>, responseHandler: @escaping (MessagesApiModel?, NSError?) -> ()) {
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        
        
        remoteAPI.forgotPassword(passwordDict, completionHandler: {
            
            responseObject,statusCode, error in
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(messageApiModel, error)
        })
    }
    
    
    open func getTenantModules(tenantID : String, responseHandler: @escaping (Array<Any>?,MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : IdentityRemoteApi = IdentityRemoteApi(httpClient: self)
        remoteAPI.getModules(tenantID: tenantID, completionHandler: {
            
            responseObject,statusCode, error in
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            var modulesArray : Array<Any> = []
            
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            if(statusCode == 200){
                
                for item in swiftyJsonVar.arrayValue {
                    let moduleEntity = ModulesApiModel(json: item)
                    modulesArray.append(moduleEntity)
                }
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                
            }else {
                messageApiModel = MessagesApiModel(json: swiftyJsonVar)
            }
            responseHandler(modulesArray, messageApiModel, error)
        })
        
    }
    
    func getMessageFromDict(msgDict : JSON) -> MessagesApiModel{
        
        let messageApiModel : MessagesApiModel = MessagesApiModel()
        let errorsAry: Array<JSON> = msgDict["errors"].arrayValue
        messageApiModel.message = errorsAry[0]["message"].string!
        messageApiModel.messageCode = errorsAry[0]["messageCode"].string!
        
        return messageApiModel
    }
    
}
