//
//  LoginModel.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/21/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit


open class LoginModel :NSObject{
    // MARK: Properties
    open var username: String = ""
    open var password: String = ""
    open var clientID: String = ""
    
    open func getUsername() -> String {
        return username
    }
    
    open func getPassword() -> String {
        return password
    }
    
    open func getClientID() -> String {
        return clientID
    }
    
    
    open func getLoginDict(login : LoginModel) -> Dictionary<String, Any>{
        
        return ["username" : login.username as AnyObject, "password" : login.password as AnyObject, "clientId" : login.clientID as AnyObject]
    }
    
}
