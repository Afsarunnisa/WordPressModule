//
//  MemberApiModel.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/21/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


open class MemberApiModel :NSObject{
    // MARK: Properties
    
    
    
    open var id: Int = 0
    open var email: String = ""
    open var firstName: String = ""
    open var lastName: String = ""
    open var phone: String = ""
    open var desc: String = ""
    open var uuid: String = ""
    
    open var isExternal: Bool = false
    
    open var userName: String = ""
    
    
    
    
    open var socialAccounts : Array<JSON> = [] // Array of socail accounts
    open var emailConnects: Array<JSON> = []
    
    
    
    public convenience init(json: JSON){
        
        self.init()
        
        id = json["id"].exists() ? json["id"].int! : 0
        email = json["email"].exists() ? json["email"].string! : ""
        firstName = json["firstName"].exists() ? json["firstName"].string! : ""
        lastName = json["lastName"].exists() ? json["lastName"].string! : ""
        
        phone = json["phone"].exists() ? json["phone"].string! : ""
        desc = json["description"].exists() ? json["description"].string! : ""
        uuid = json["uuid"].exists() ? json["uuid"].string! : ""
        isExternal = json["isExternal"].exists() ? json["isExternal"].bool! : false
        userName = json["userName"].exists() ? json["userName"].string! : ""
        
        socialAccounts = json["socialAccounts"].exists() ? json["socialAccounts"].array! : []
        emailConnects = json["emailConnects"].exists() ? json["emailConnects"].array! : []
        
        
        
    }
    
}
