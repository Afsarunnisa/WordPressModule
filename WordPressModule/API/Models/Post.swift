//
//  Post.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 27/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Post: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    
    public dynamic var id = 0
    public dynamic var title = ""
    public dynamic var content = ""
    public dynamic var excerpt = ""
    public dynamic var slug = ""
    public dynamic var type = ""
    public dynamic var link = ""
    public dynamic var date: Date?
    public dynamic var modified: Date?
    public dynamic var commentCount = 0
    public dynamic var author = ""
    
    public dynamic var media: Media?
//    public dynamic var author: User?
    public var categories = List<CategoryId>()

    
//    public var categories = List<Category>()
    public var tags = List<Category>()
    
    

    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    public convenience init(json: JSON) {
        self.init()
        
        
        print("post json \(json)")
        
        id = json["id"].intValue
        title = json["title"]["rendered"].stringValue
        content = json["content"]["rendered"].stringValue
        excerpt = json["excerpt"]["rendered"].stringValue
        slug = json["slug"].stringValue
        type = json["type"].stringValue
        link = json["link"].stringValue
        //                postDetails.date = item["date"].
        //                postDetails.modified = item["modified"]
        commentCount = json["commentCount"].intValue
        author = json["author"].stringValue
        
        //                postDetails.categories = item["categories"] as! Category
        //                postDetails.tags = item["tags"] as! Category
        
        
//        categories = json["categories"].arrayValue
  
        let categorylist : Array<JSON> = json["categories"].arrayValue
        categories = List<CategoryId>(categorylist.map(CategoryId.init))

        
        
        // Need to change respeonse get category as Aarray of dictinaory
        
//        let categorylist : Array<JSON> = json["categories"].arrayValue
//        categories = List<Category>(categorylist.map(Category.init))
//        
//        
//        let tagslist: Array<JSON> = json["tags"].arrayValue
//        tags = List<Category>(tagslist.map(Category.init))
//
//
//        print("tags \(tags)")

    }

}

