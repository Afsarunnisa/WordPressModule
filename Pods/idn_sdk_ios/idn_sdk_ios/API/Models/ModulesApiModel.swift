//
//  ModulesApiModel.swift
//  Pods
//
//  Created by Afsarunnisa on 12/23/16.
//
//

import Foundation
import SwiftyJSON

@objc open class ModulesApiModel:NSObject {
    // MARK: Properties
    open var name : String = ""
    open var id: Int = 0
    
    open var uuid : String = ""
    open var isMarketPlace : Bool!
    
    open var moduleKey : String = ""
    open var moduleStatus : String = ""
    open var moduleType : String = ""
    
    
    
    open var roles : Array<JSON> = [] // Array of socail accounts
    open var authorities: Array<JSON> = []
    open var scopes: Array<JSON> = []
    
    
    open var moduleImages: Array<JSON> = []
    
    
    open var apiDefinitionUrl : String = ""
    open var uiLibraryUrl : String = ""
    open var docUrl : String = ""
    
    open var logoImage: Array<JSON> = []
    
    
    open var tags : String = ""
    open var moduleDescription : String = ""
    
    open var apiClients: Array<JSON> = []
    
    
    public convenience init(json: JSON){
        
        self.init()
        
        name = json["name"].exists() ? json["name"].string! : ""
        id = json["id"].exists() ? json["id"].int! : 0
        uuid = json["uuid"].exists() ? json["uuid"].string! : ""
        isMarketPlace = json["isMarketPlace"].exists() ? json["isMarketPlace"].bool! : false
        
        
        
        moduleKey = json["moduleKey"].exists() ? json["moduleKey"].string! : ""
        moduleStatus = json["moduleStatus"].exists() ? json["moduleStatus"].string! : ""
        moduleType = json["moduleType"].exists() ? json["moduleType"].string! : ""
        
        
        roles = json["roles"].exists() ? json["roles"].array! : []
        authorities = json["authorities"].exists() ? json["authorities"].array! : []
        scopes = json["scopes"].exists() ? json["scopes"].array! : []
        
        moduleImages = json["moduleImages"].exists() ? json["moduleImages"].array! : []
        
        
        apiDefinitionUrl = json["apiDefinitionUrl"].exists() ? json["apiDefinitionUrl"].string! : ""
        uiLibraryUrl = json["uiLibraryUrl"].exists() ? json["uiLibraryUrl"].string! : ""
        docUrl = json["docUrl"].exists() ? json["docUrl"].string! : ""
        
        
        logoImage = json["logoImage"].exists() ? json["logoImage"].array! : []
        
        tags = json["tags"].exists() ? json["tags"].string! : ""
        moduleDescription = json["description"].exists() ? json["description"].string! : ""
        
        
        apiClients = json["apiClients"].exists() ? json["apiClients"].array! : []
        
        
        
    }
    
}
