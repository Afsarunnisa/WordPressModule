//
//  TokenApi.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 9/27/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import SwiftyJSON

open class TokenApi : NetworkApi {
    
    required public init() {
        super.init()
        setModuleName("token")
        setRemoteApiClass(TokenRemoteApi.self)
    }
    
    
    open func getClientToken(_ responseHandler: @escaping (TokenApiModel?, MessagesApiModel?, NSError?) -> ()){
        
        let remoteAPI : TokenRemoteApi = TokenRemoteApi(httpClient: self)
        let apiContext : IdsIosApiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let clientCredentials = apiContext.getClientCredentials()
        
        
        let clientID : String = clientCredentials.object(forKey: "client_id") as! String
        let clientSecret : String = clientCredentials.object(forKey: "client_secret") as! String
        
        let clientTokenDict: Dictionary<String, AnyObject> = ["client_id" : clientID as AnyObject, "client_secret" : clientSecret as AnyObject, "grant_type" : "client_credentials" as AnyObject, "scope":"" as AnyObject]
        
        
        remoteAPI.getClientToken(clientTokenDict) { (responseObject, statusCode, error) in
            
            var tokenApiModel: TokenApiModel?
            var messageApiModel: MessagesApiModel = MessagesApiModel()
            
            if(error == nil){
                
                let swiftyJsonVar = JSON(responseObject as Any)
                
                if(statusCode == 200){
                    
                    tokenApiModel = TokenApiModel(json : swiftyJsonVar)
                    apiContext.setClientToken(tokenApiModel!)
                    
                }else if(statusCode == 400){
                    messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
                }else {
                    messageApiModel = MessagesApiModel(json: swiftyJsonVar)
                }
            }else{
                print("error \(String(describing: error))")
            }
            
            responseHandler(tokenApiModel, messageApiModel, error)
        }
    }
    
    
    func getMessageFromDict(msgDict : JSON) -> MessagesApiModel{
        
        let messageApiModel : MessagesApiModel = MessagesApiModel()
        let errorsAry: Array<JSON> = msgDict["errors"].arrayValue
        
        messageApiModel.message = errorsAry[0]["message"].string!
        messageApiModel.messageCode = errorsAry[0]["messageCode"].string!
        
        return messageApiModel
    }
}
