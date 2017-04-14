//
//  MediaApi.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 10/5/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

open class MediaApi : NetworkApi {
    
    required public init() {
        super.init()
        setModuleName("media")
        setRemoteApiClass(MediaRemoteApi.self)
    }
    
    
    open func getMedia(_ userID : String, responseHandler: @escaping (MediaApiModel?, MessagesApiModel?, NSError?) -> ()){
        
        
        let remoteAPI : MediaRemoteApi = MediaRemoteApi(httpClient: self)
        
        
        remoteAPI.getMedia(userID, completionHandler: {
            responseObject,statusCode, error in
            
            var mediaApiModel : MediaApiModel = MediaApiModel()
            var messageApiModel : MessagesApiModel = MessagesApiModel()
            
            let swiftyJsonVar = JSON(responseObject as Any)
            
            
            if(statusCode == 200){
                mediaApiModel = self.respMediaFromJson(JSONdata: swiftyJsonVar)
            }else if(statusCode == 400){
                messageApiModel = self.getMessageFromDict(msgDict: swiftyJsonVar)
            }else {
                messageApiModel.message = swiftyJsonVar["message"].string!
                messageApiModel.messageCode = swiftyJsonVar["messageCode"].string!
            }
            
            responseHandler(mediaApiModel,messageApiModel, error)
        })
    }
    
    
    open func uploadMedia(_ userID: String, imgName: String, mediaFor: String, responseHandler: @escaping (MediaApiModel?, NSError?) -> ()){
        
        let remoteAPI : MediaRemoteApi = MediaRemoteApi(httpClient: self)
        
        remoteAPI.uploadMedia(userID, imgName: imgName, mediaFor: mediaFor, completionHandler: {
            
            responseObject, error in
            
            var mediaApiModel : MediaApiModel = MediaApiModel()
            let swiftyJsonVar = JSON(responseObject as Any)
            
            
            if(error == nil){
                
                mediaApiModel = self.respMediaFromJson(JSONdata: swiftyJsonVar)
                
            }else{
                let errorStr : String = (error?.localizedDescription)!
                print("Request failed with error: \(errorStr)")
            }
            responseHandler(mediaApiModel, error)
        })
    }
    
    
    
    func respMediaFromJson(JSONdata : JSON) -> MediaApiModel {
        let mediaApi = MediaApiModel()
        
        
        mediaApi.mediaExtension = JSONdata["extension"].stringValue
        mediaApi.supportedsizes = JSONdata["supportedsizes"].stringValue
        
        var mediaDetailsList : Array<Any>! = []
        
        let list: Array<JSON> = JSONdata["mediaFileDetailsList"].arrayValue
        
        for item in list {
            
            let mediaFileDetails = MediaFileDetailsApiModel()
            
            mediaFileDetails.mediapath = item["mediapath"].stringValue
            mediaFileDetails.mediatype = item["mediatype"].stringValue
            
            mediaDetailsList.append(mediaFileDetails)
        }
        
        mediaApi.mediaFileDetailsList = mediaDetailsList
        return mediaApi
    }
    
    
    func getMessageFromDict(msgDict : JSON) -> MessagesApiModel{
        
        let messageApiModel : MessagesApiModel = MessagesApiModel()
        let errorsAry: Array<JSON> = msgDict["errors"].arrayValue
        
        messageApiModel.message = errorsAry[0]["message"].string!
        messageApiModel.messageCode = errorsAry[0]["messageCode"].string!
        
        return messageApiModel
    }
    
}
