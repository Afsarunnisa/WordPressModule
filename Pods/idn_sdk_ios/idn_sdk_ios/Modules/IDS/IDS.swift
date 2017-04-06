//
//  IDS.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 8/11/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class IDS {
    
    static var registry : Dictionary<String, AnyObject> = [:]
    
    open static func getModuleApi(_ moduleName : String) -> AnyObject {
        return getModeuleApi(moduleName,contextName: "app")
    }
    
    static func getModeuleApi(_ moduleName : String, contextName : String) -> AnyObject{
        
        let moduleApi : AnyObject = "" as AnyObject
        let keysArray : Array = Array(registry.keys)

        if(!keysArray.contains(moduleName)){
            
        }else{
            
            let apiClass : NetworkApi.Type = registry[moduleName] as! NetworkApi.Type
            let api : NetworkApi = apiClass.init()
            
            let apiContext : ApiContext = AbstractApiContext.get(contextName)
            
            api.setApiContext(apiContext)
            
            var host : String = api.getHost()
            
            if(host == ""){
                host = "http://api.qa1.nbos.in/"
            }
            
            api.setHost(host)
            return registry[moduleName]!
        }
        return moduleApi
    }
    
    open static func register(_ moduleName : String, clazz : AnyClass){
        registry[moduleName] = clazz

    }
    
}

