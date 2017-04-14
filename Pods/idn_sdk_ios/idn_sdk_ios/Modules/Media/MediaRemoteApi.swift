//
//  MediaRemoteApi.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 10/5/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation

open class MediaRemoteApi  {
    
    let baseMediaUrl : String = "api/media/v0"
    
    
    var mediaUrl : String = ""
    
    let networkAPI : NetworkApi!
    let userTokenheaders : [String: String]
    
    var apiContext : IdsIosApiContext!

    init(httpClient: AnyObject) {
        
        networkAPI = NetworkApi()
        
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let userTokenModel : TokenApiModel = apiContext.getUserToken("identity") as! TokenApiModel
        let userToken  = userTokenModel.access_token
        
        userTokenheaders = [
            "Authorization": "Bearer \(userToken)"
        ]
    
        mediaUrl = "\(baseMediaUrl)/media"
    }
    
    
    
    func getMedia(_ userID : String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let hostUrl : String = apiContext.getHost("app")
        let url = "\(hostUrl)\(mediaUrl)?id=\(userID)&mediafor=profile"
        networkAPI.get(url, paramsDict: Dictionary(), headers: userTokenheaders, completionHandler: completionHandler)
    }
    
    
    func uploadMedia(_ userID: String, imgName: String, mediaFor: String, completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        
        let hostUrl : String = apiContext.getHost("app")
        let connectUrl = "\(hostUrl)\(mediaUrl)"
        
        networkAPI.upload(connectUrl, fileName: imgName, userID: userID, mediaFor: mediaFor, paramsDict: Dictionary(), headers: userTokenheaders, completionHandler: completionHandler)
        
    }
    
}
