//
//  CategoryId.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 31/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class CategoryId: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    
    public dynamic var categoryID = ""

    
    public convenience init(json: JSON) {
        self.init()
        
        print("json \(json)")
        
        categoryID = json.stringValue
    }

}
