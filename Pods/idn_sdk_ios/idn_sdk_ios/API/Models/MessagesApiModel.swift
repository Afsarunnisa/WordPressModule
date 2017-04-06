//
//  MessagesApiModel.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 10/5/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc open class MessagesApiModel:NSObject {
    // MARK: Properties
    open var message : String = ""
    open var messageCode : String = ""
    
    
    
    public convenience init(json: JSON){
        
        self.init()
        
        message = json["message"].exists() ? json["message"].string! : ""
        messageCode = json["messageCode"].exists() ? json["messageCode"].string! : ""
    }
    
    
}
