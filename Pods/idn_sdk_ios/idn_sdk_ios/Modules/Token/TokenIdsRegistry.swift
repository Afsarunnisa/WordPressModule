//
//  TokenIdsRegistry.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 9/27/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


open class TokenIdsRegistry {
    public init(){
        IDS.register("token", clazz: TokenApi.self)
    }
}
