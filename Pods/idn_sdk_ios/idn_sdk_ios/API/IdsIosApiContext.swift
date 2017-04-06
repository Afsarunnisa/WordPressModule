//
//  IdsIosApiContext.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 9/28/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class IdsIosApiContext : InMemoryApiContext {
    
    let CLIENT_ID_PROPERTY = "WAVELABS_CLIENT_ID"
    let CLIENT_SECRET_PROPERTY = "WAVELABS_CLIENT_SECRET"
    
    
    public override init(name : String) {
        
        super.init(name: name)
        _ = super.getName()
        
        
        let clientID = self.getConfig(name: CLIENT_ID_PROPERTY) != "" ? self.getConfig(name: CLIENT_ID_PROPERTY) : "sample-app-client"
        let clientSecret = self.getConfig(name: CLIENT_SECRET_PROPERTY) != "" ? self.getConfig(name: CLIENT_SECRET_PROPERTY) : "sample-app-secret"
        
        let clientCredentials: Dictionary<String, AnyObject> = ["client_id" : clientID as AnyObject, "client_secret" : clientSecret as AnyObject]
        
        
        super.setClientCredentials(clientCredentials)
        
    }
    
    
    
    
    
    
    
    @objc required public init() {
        
        super.init(name: "app")
        
        
        fatalError("init() has not been implemented")
        
    }
    
    
    
    override func getClientCredentials() -> AnyObject{
        return super.getClientCredentials()
    }
    
    override func setClientToken(_ tokenApiModel : TokenApiModel){
        self.saveModel("token.client", model: tokenApiModel)
        super.setClientToken(tokenApiModel)
    }
    
    
    override func getClientToken() -> AnyObject {
        var tokenApiModel : TokenApiModel = super.getClientToken() as! TokenApiModel
        
        if(tokenApiModel.access_token != ""){
            return tokenApiModel
        }
        
        tokenApiModel = self.readModel("token.client") as! TokenApiModel
        
        super.setClientToken(tokenApiModel)
        return tokenApiModel
    }
    
    
    
    override func setUserToken(_ moduleName: String, tokenApiModel : TokenApiModel){
        self.saveModel("token.user", model: tokenApiModel)
        super.setUserToken(moduleName, tokenApiModel: tokenApiModel)
        
    }
    
    
    override func getUserToken(_ moduleName: String) -> AnyObject {
        var tokenApiModel : TokenApiModel = super.getUserToken(moduleName) as! TokenApiModel
        
        if(tokenApiModel.access_token != ""){
            return tokenApiModel
        }
        
        tokenApiModel = self.readModel("token.user") as! TokenApiModel
        
        super.setClientToken(tokenApiModel)
        return tokenApiModel
    }
    
    
    open override func getHost(_ moduleName: String) -> String {
        
        return self.getConfig(name: "\(moduleName.uppercased())_BASE_URL") != "" ? self.getConfig(name: "\(moduleName.uppercased())_BASE_URL") : "http://api.qa1.nbos.in/"
    }
    
    
    open override func setHost(_ moduleName: String, host : String) {
        super.setHost(moduleName, host: host)
    }
    
    
    
    func saveModel(_ defaultName : String, model: NSObject){
        
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: model)
        
        print("  encodedData  \(encodedData) ")
        
        
        let defaults = UserDefaults.standard
        defaults.set(encodedData, forKey: defaultName)
        defaults.synchronize()
    }
    
    
    func readModel(_ defaultName : String) -> AnyObject {
        
        let defaults = UserDefaults.standard
        
        let decoded  = defaults.object(forKey: "teams") as! Data
        let model : AnyObject = (NSKeyedUnarchiver.unarchiveObject(with: decoded)! as AnyObject)
        
        
        
        //        let model : AnyObject = defaults.objectForKey(defaultName)!
        return model
    }
    
    
    
    
    func getConfig(name : String) -> String {
        
        var infoDict : Dictionary<String, Any> = [:]
        
        if Bundle.main.infoDictionary?["WavelabsAPISettings"] != nil {
            infoDict = Bundle.main.infoDictionary?["WavelabsAPISettings"]! as! Dictionary<String, Any>
        }
        
        if(!infoDict.isEmpty){
            return infoDict[name] != nil ? infoDict[name] as! String : ""
        }else{
            return ""
        }
        
    }
    
}
