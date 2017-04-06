//
//  WordpressApi.swift
//  WordPress_Sdk
//
//  Created by Afsarunnisa on 25/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import idn_sdk_ios
import SwiftyJSON
import RealmSwift


open class WordpressApi : NetworkApi {
    
    
    required public init() {
        super.init()
        setModuleName("wordpress")
        setRemoteApiClass(WordpressRemoteApi.self)
    }

    
    
    open func getCategories(parentID : String, itemsPerPage: String,responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()) {
    
        let remoteAPI : WordpressRemoteApi = WordpressRemoteApi(httpClient: self)
        
        remoteAPI.getCategories(parentID: parentID, itemsPerPage: itemsPerPage, completionHandler: {responseObject,statusCode, error in

            let swiftyJsonVar = JSON(responseObject as Any)
            
            
            print("swiftyJsonVar \(swiftyJsonVar)")
            
            var messageApiModel : MessagesApiModel = MessagesApiModel()

            if(statusCode == 200){
                
                self.categoriesEntity(categories: swiftyJsonVar)
            
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)

        })
    }
    
    
    open func getPosts(categotyID : Int, itemsPerPage: Int, currentPage: Int, searchText: String,responseHandler: @escaping (NSArray?, MessagesApiModel?, NSError?) -> ()) {
        
        
//        "http://hariome.com/wp-json/wp/v2/posts?per_page=20&page=1&filter[cat]=5013"

        let remoteAPI : WordpressRemoteApi = WordpressRemoteApi(httpClient: self)

        
        remoteAPI.getPosts(categoryID: categotyID, itemsPerPage: itemsPerPage, pageNumber: currentPage, searchText: searchText, completionHandler: { responseObject,statusCode, error in
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            print("swiftyJsonVar \(swiftyJsonVar)")

            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            if(statusCode == 200){
                
                self.postsEntity(posts: swiftyJsonVar)
                
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(NSArray(),messageApiModel, error)

            
        })
    
    
    }
    
    
    
    
    func getMessageFromDict(msgDict : JSON) -> MessagesApiModel{
        
        let messageApiModel : MessagesApiModel = MessagesApiModel()
        let errorsAry: Array<JSON> = msgDict["errors"].arrayValue
        
        messageApiModel.message = errorsAry[0]["message"].string!
        messageApiModel.messageCode = errorsAry[0]["messageCode"].string!
        
        return messageApiModel
    }
    
    
    func postsEntity(posts : JSON){
        
        print("posts \(posts)")
        
        let list: Array<JSON> = posts.arrayValue

        
        let realm = try! Realm()
        
        try! realm.write({
            
            
            let posts = List<Post>(list.map(Post.init))
            
            realm.add(List(posts), update: true)
            
        })
    }
    
    
    func categoriesEntity(categories : JSON) {

        let list: Array<JSON> = categories.arrayValue
        
        let realm = try! Realm()

        try! realm.write({
            for item in list {
                let categoryDetails = Category()
                
                
                categoryDetails.id = item["id"].intValue
                categoryDetails.name = item["name"].stringValue
                categoryDetails.slugName = item["slug"].stringValue

                realm.add(categoryDetails, update: true)
            }
        })
    }

    
    
}
