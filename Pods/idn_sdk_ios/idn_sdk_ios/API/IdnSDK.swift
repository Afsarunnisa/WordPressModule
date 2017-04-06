//
//  IdnSDK.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 8/11/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class IdnSDK {
    
    
    public init(apiContext : ApiContext) {
        
        AbstractApiContext.registerApiContext(apiContext)
        
    }
}
