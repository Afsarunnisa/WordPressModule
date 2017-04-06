//
//  WordpressRemoteApi.swift
//  WordPress_Sdk
//
//  Created by Afsarunnisa on 25/01/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
import idn_sdk_ios


open class WordpressRemoteApi  {

    let baseWordpressUrl : String = "/wp-json/wp/v2"


    var categoriesUrl : String = ""
    var articlesUrl : String = ""

    
    let networkAPI : NetworkApi!
    var apiContext : IdsIosApiContext!
    let clientTokenheaders : [String: String] = ["":""]

    
    init(httpClient: AnyObject) {
        
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        networkAPI = NetworkApi()
        
        
        categoriesUrl = "\(baseWordpressUrl)/categories"
        articlesUrl = "\(baseWordpressUrl)/posts"
    }
    
    
    func getCategories(parentID : String, itemsPerPage: String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
    
    
        let parentIDStr = parentID != "" ? "parent=\(parentID)" : ""
        let itemsperPageStr = itemsPerPage != "" ? "per_page=\(itemsPerPage)" : ""
        
        let extenderdUrl = "/?\(parentIDStr)&\(itemsperPageStr)"
        
        
        let hostUrl : String = apiContext.getHost("wordpress")        

        let connectUrl = "\(hostUrl)\(categoriesUrl)\(extenderdUrl)"

        networkAPI.get(connectUrl, paramsDict: [:], headers: [:], completionHandler: completionHandler)

    }
    
    
    func getPosts(categoryID: Int, itemsPerPage: Int, pageNumber: Int, searchText: String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        

        
        let catIDStr = categoryID != 0 ? "filter[cat]=\(categoryID)" : ""
        let itemsperPageStr = itemsPerPage != 0 ? "per_page=\(itemsPerPage)" : ""
        let pageNumStr = itemsPerPage != 0 ? "page=\(pageNumber)" : ""
        let searchTextStr = itemsPerPage != 0 ? "search=\(searchText)" : ""

        let extenderdUrl = "/?\(itemsperPageStr)&\(pageNumStr)&\(catIDStr)&\(searchTextStr)"

        let hostUrl : String = apiContext.getHost("wordpress")
        
        let connectUrl = "\(hostUrl)\(articlesUrl)\(extenderdUrl)"

        
        networkAPI.getWithEncode(connectUrl, paramsDict: [:], headers: [:], completionHandler: completionHandler)
    }
    
    
}

