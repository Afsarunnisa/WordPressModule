//
//  MediaIdsRegistry.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 10/5/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class MediaIdsRegistry {
    
    public init(){
        IDS.register("media", clazz: MediaApi.self)
    }
}
