 //
//  AbstractApiContext.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 8/11/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class AbstractApiContext : ApiContext {
      
    @objc required public init() {
  
    }
    
    open var name : String = ""

    
    init(name: String) {
        if(name == ""){
            self.name = "app"
        }else{
            self.name = name
        }
    }
    
    @objc open func getName() -> String{
        return name
    }

    
    static var apiContexts: Dictionary<String, ApiContext> = [:]
    
    static func registerApiContext(_ apiContext : ApiContext) {
        apiContexts[apiContext.getName!()] = apiContext
    }
    
    open static func get(_ name :String) -> ApiContext {
        
        var ctx : ApiContext = apiContexts[name]!
        
        if(ctx.getName!() == ""){
            
            ctx = InMemoryApiContext.init(name: name)
            self.registerApiContext(ctx)
        }
        
        return ctx
    }
    
    open func AbstractApiContext(){
        
    }
    
    open func AbstractApiContext(_ name : String){
        self.name = name
    }
    
}
