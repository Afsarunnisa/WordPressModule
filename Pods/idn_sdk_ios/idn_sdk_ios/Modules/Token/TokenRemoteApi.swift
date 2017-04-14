//
//  TokenRemoteApi.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 9/27/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


open class TokenRemoteApi  {
    
    let tokenUrl : String = "oauth/token"
    let networkAPI : NetworkApi!
    var apiContext : IdsIosApiContext!
    
    
    init(httpClient: AnyObject) {
        
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        networkAPI = NetworkApi()
    }
    
    
    open func getClientToken(_ tokenDetails : Dictionary<String, Any>,completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        let networkAPI : NetworkApi = NetworkApi()
        
        let hostUrl : String = apiContext.getHost("app")
        let connectUrl = "\(hostUrl)\(tokenUrl)"
        
        networkAPI.post(connectUrl, paramsDict: tokenDetails, headers: [:], completionHandler: completionHandler)
    }
    
    
    func refreshAccessToken(_ completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        let networkAPI : NetworkApi = NetworkApi()
        
        
        let headers = [
            "Authorization": "Bearer 123"
        ]
        
        let hostUrl : String = apiContext.getHost("app")
        let connectUrl = "\(hostUrl)\(tokenUrl)"
        
        networkAPI.post(connectUrl, paramsDict: Dictionary(), headers: headers, completionHandler: completionHandler)
    }
    
}
