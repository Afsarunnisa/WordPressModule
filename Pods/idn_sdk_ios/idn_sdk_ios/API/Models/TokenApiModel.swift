//
//  TokenApiModel.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 8/11/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


import UIKit
import SwiftyJSON


open class TokenApiModel :NSObject{
    // MARK: Properties
    open var access_token: String = ""
    open var expires_in: Int = 0
    open var refresh_token: String = ""
    open var scope: String = ""
    open var token_type: String = ""
    
    public convenience init(json: JSON){
        
        self.init()
        
        access_token = json["access_token"].exists() ? json["access_token"].string! : ""
        expires_in = json["expires_in"].exists() ? json["expires_in"].int! : 0
        refresh_token = json["refresh_token"].exists() ? json["refresh_token"].string! : ""
        scope = json["scope"].exists() ? json["scope"].string! : ""
        token_type = json["token_type"].exists() ? json["token_type"].string! : ""
    }
    
    
    
    open func encodeWithCoder(_ coder: NSCoder) {
        coder.encode(self.access_token, forKey: "access_token")
        coder.encodeCInt(Int32(self.expires_in), forKey: "expires_in")
        coder.encode(self.refresh_token, forKey: "refresh_token")
        coder.encode(self.scope, forKey: "scope")
        coder.encode(self.token_type, forKey: "token_type")
    }
    
    
    
    
    open func getAccessToken() -> String {
        return access_token
    }
    
    open func getExpiresIn() -> Int {
        return expires_in
    }
    
    open func getRefreshToken() -> String {
        return refresh_token
    }
    
    open func getScope() -> String {
        return scope
    }
    
    open func getTokenType() -> String {
        return token_type
    }
    
    
}
