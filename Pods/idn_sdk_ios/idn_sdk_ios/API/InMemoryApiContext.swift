//
//  InMemoryApiContext.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/20/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


open class InMemoryApiContext : AbstractApiContext {
    
    
    var store : Dictionary<String, Any> = [:]
    var hosts : Dictionary<String, Any> = [:]
    var tokens : Dictionary<String, Any> = [:]

    
    override init(name: String) {
        super.init(name: name)
    }
    
    @objc required public init() {
        fatalError("init() has not been implemented")
    }
    
    
    override open func getName() -> String{
        return name
    }
    
    
    func setClientCredentials(_ credentials : Dictionary<String, Any>){
        store["client.credentials"] = credentials
    }
    
    func getClientCredentials() -> AnyObject{
        return store["client.credentials"]! as AnyObject
    }
    
    
    func setClientToken(_ tokenApiModel : TokenApiModel){
        store["token.client"] = tokenApiModel
    }
    
    func getClientToken() -> AnyObject{
        return store["token.client"]! as AnyObject
    }
    
    
    func setUserToken(_ moduleName: String, tokenApiModel : TokenApiModel){
        tokens[moduleName] = tokenApiModel
        
        if(tokens["default"] == nil){
            tokens["default"] = tokenApiModel
        }
    }
    
    func getUserToken(_ moduleName: String) -> AnyObject{
        
        var tokenApiModel : TokenApiModel = tokens[moduleName] as! TokenApiModel
        
        if(tokenApiModel.access_token == ""){ // check token nil properly
            tokenApiModel  = tokens["default"] as! TokenApiModel
        }
        
        return tokenApiModel
    }
    
    
    func setHost(_ moduleName: String, host : String){
        hosts[moduleName] = host
        
        if(hosts["default"] == nil){
            hosts["default"] = host
        }
        
    }
    
    func getHost(_ moduleName: String) -> String{
        
        
        let arrayOfKeys : Array = Array(hosts.keys)
        if (arrayOfKeys.contains(moduleName)) {
            return hosts[moduleName]! as! String
        }else {
            return hosts["default"]! as! String
        }
    }
    
    
    
}
