//
//  NewMemberApiModel.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/21/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


open class NewMemberApiModel :NSObject{
    // MARK: Properties
    open var memberApiModel : MemberApiModel!
    open var tokenApiModel : TokenApiModel!
    
    
    public convenience init(json: JSON){
        
        self.init()
        
        memberApiModel = MemberApiModel(json: json["member"])
        tokenApiModel = TokenApiModel(json: json["token"])
        
    }
    
    
    open func getMember() -> MemberApiModel {
        return memberApiModel
    }
    
    open func getToken() -> TokenApiModel {
        return tokenApiModel
    }
    
    
}
