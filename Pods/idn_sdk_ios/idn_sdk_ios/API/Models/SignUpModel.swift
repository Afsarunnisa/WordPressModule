//
//  SignUpModel.swift
//  idn_sdk_ios
//
//  Created by Afsarunnisa on 31/03/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit


open class SignUpModel :NSObject{
    // MARK: Properties
    open var email: String = ""
    open var password: String = ""
    open var firstName: String = ""
    open var lastName: String = ""
    open var username: String = ""
    open var clientID: String = ""
    
    
    open func getEmail() -> String {
        return email
    }
    
    open func getPassword() -> String {
        return password
    }
    
    
    open func getFirstName() -> String {
        return firstName
    }
    
    open func getLastName() -> String {
        return lastName
    }
    
    open func getUsername() -> String {
        return username
    }
    
    open func getClientID() -> String {
        return clientID
    }
    
    
    open func getSignUpDict(signUp : SignUpModel) -> Dictionary<String, Any>{
        
        
        return ["email" : signUp.email as AnyObject, "password" : signUp.password as AnyObject,"firstName" : signUp.firstName as AnyObject, "lastName" : signUp.lastName as AnyObject,"username" : signUp.username as AnyObject, "clientId" : signUp.clientID as AnyObject]
        
        
    }
    
    
}
