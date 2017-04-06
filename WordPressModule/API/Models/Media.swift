//
//  Media.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 27/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Media: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    public dynamic var link = ""
    public dynamic var width = 0
    public dynamic var height = 0
    
    public dynamic var thumbnailLink = ""
    public dynamic var thumbnailWidth = 0
    public dynamic var thumbnailHeight = 0

    
    public convenience init(json: JSON) {
        self.init()
        
//        link = json["id"].intValue
//        name = json["name"].stringValue
//        slugName = json["slugName"].stringValue
//        parent = json["parent"].intValue
    }

}

