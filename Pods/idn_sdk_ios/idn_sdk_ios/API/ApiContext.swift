//
//  ApiContext.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 8/11/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


@objc public protocol ApiContext {
    
    
    @objc optional func getName() -> String
    
    @objc optional func setHost(_ moduleName : String, host : String)
    @objc optional func getHost(_ moduleName : String) -> String
    
    @objc optional func setClientCredentials(_ dict : Dictionary<String, Any>)
    @objc optional func setClientToken(_ tokenApiModel : TokenApiModel)
    
    @objc optional func getClientCredentials  () -> Dictionary<String, Any>
    @objc optional func getClientToken() -> TokenApiModel
    
    @objc optional func setUserToken(_ moduleName : String, tokenApiModel : TokenApiModel)
    @objc optional func getUserToken(_ moduleName : String) -> TokenApiModel
    
}
