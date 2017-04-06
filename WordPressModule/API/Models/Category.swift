//
//  Category.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 27/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Category: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    public dynamic var id : Int = 0
    public dynamic var name : String = ""
    public dynamic var slugName : String = ""
    public dynamic var parent = 0

    override static func primaryKey() -> String? {
        return "id"
    }
    
    public override static func indexedProperties() -> [String] {
        return [
            "name",
            "slug"
        ]
    }

    
    
    public convenience init(json: JSON) {
        self.init()
        
        print("json \(json)")
        
        id = json["id"].intValue
        name = json["name"].stringValue
        slugName = json["slugName"].stringValue
        parent = json["parent"].intValue
    }

}
