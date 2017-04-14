//
//  NetworkApi.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/15/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation
import Alamofire

open class NetworkApi {
    
    
    var moduleName : String = ""
    var host : String = ""
    var apiContext : IdsIosApiContext!
    
    var remoteApiClass : AnyClass! = nil
    
    
    required public init() {
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
    }
    
    func setHost(_ host : String){
        self.host = host
    }
    
    func getHost() -> String{
        return self.host
    }
    
    
    open func setModuleName(_ moduleName : String){
        self.moduleName = moduleName
    }
    
    open func getModuleName() -> String{
        return self.moduleName
    }
    
    
    func setApiContext(_ apicontext : ApiContext) {
    }
    
    
    
    open func setRemoteApiClass(_ remoteApiClass : AnyClass){
        self.remoteApiClass = remoteApiClass
    }
    
    open func getRemoteApiClass() -> AnyClass{
        return self.remoteApiClass
    }
    
    
    open func get(_ requestUrl: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        let params = self.getParams(paramsDict)
        
        Alamofire.request(requestUrl, method:.get, parameters:params, headers: headers).responseJSON { response in
            debugPrint(response)
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?,statusCode, nil)
            case .failure(let error):
                completionHandler(nil,statusCode, error as NSError?)
            }
        }
        
    }
    
    
    open func getWithEncode(_ requestUrl: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        let params = self.getParams(paramsDict)
        
        
        Alamofire.request(requestUrl, method: .get, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?,statusCode, nil)
            case .failure(let error):
                completionHandler(nil,statusCode, error as NSError?)
            }
        }
    }
    
    
    open func post(_ url: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        
        let params = self.getParams(paramsDict)
        
        Alamofire.request(url, method: .post, parameters: params, headers: headers).responseJSON {
            response in
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?, statusCode, nil)
            case .failure(let error):
                completionHandler(nil, statusCode, error as NSError?)
            }
        }
    }
    
    
    open func postWithEncode(_ url: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int,NSError?) -> ()) {
        
        let params = self.getParams(paramsDict)
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?, statusCode, nil)
            case .failure(let error):
                completionHandler(nil, statusCode, error as NSError?)
            }
        }
    }
    
    
    
    open func putWithEncode(_ url: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int,NSError?) -> ()) {
        
        
        let params = self.getParams(paramsDict)
        
        Alamofire.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?,statusCode, nil)
            case .failure(let error):
                completionHandler(nil,statusCode, error as NSError?)
            }
        }
    }
    
    open func delete(_ url: String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, Int,NSError?) -> ()){
        
        let params = self.getParams(paramsDict)
        
        Alamofire.request(url, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON {
            response in
            
            let statusCode : Int = response.response?.statusCode != nil ? (response.response?.statusCode)! : 0
            
            switch response.result {
            case .success(let value):
                
                completionHandler(value as AnyObject?, statusCode, nil)
            case .failure(let error):
                completionHandler(nil, statusCode, error as NSError?)
            }
            
        }
    }
    
    
    open func upload(_ url: String,fileName : String, userID: String, mediaFor : String, paramsDict: Dictionary<String, Any>, headers: [String: String], completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        
        let URL = try! URLRequest(url: url, method: .post, headers: headers)
        
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        
        var fileName : String = ""
        var storePath : String = ""
        var imageData : Data = Data()
        
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first {
            let imagesDirectory = (dirPath as NSString).appendingPathComponent("Images")
            
            fileName  =  NSString(format:"%@.png", userID) as String
            storePath = (imagesDirectory as NSString).appendingPathComponent(fileName)
            
            let imageFromPath = UIImage(contentsOfFile: storePath)!
            
            let imageis: UIImage = imageFromPath
            
            let myThumb1 = imageis.resizeWith(percentage: 0.1)
            imageData = UIImagePNGRepresentation(myThumb1!)! as Data
            
        }
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append((userID.data(using: String.Encoding.utf8)!), withName: "id")
                multipartFormData.append((mediaFor.data(using: String.Encoding.utf8)!), withName: "mediafor")
                multipartFormData.append(imageData, withName: "file", fileName: fileName, mimeType: "image/png")
        },
            with: URL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in switch response.result {
                    case .success(let JSON):
                        print("Success with JSON: \(JSON)")
                        
                        completionHandler(JSON as AnyObject?, nil)
                        
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        completionHandler(nil, error as NSError?)
                        }
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    

    open func getParams(_ paramsDict : Dictionary<String, Any>) -> [String : AnyObject]{
        var parameters : [String : AnyObject] = [:]
        
        for index in 0 ..< paramsDict.keys.count {
            let keysList : NSArray = Array(paramsDict.keys) as NSArray
            
            let key : String = keysList.object(at: index) as! String
            var value : AnyObject!
            
            let val : AnyObject = paramsDict[key] as AnyObject
            
            if (val is Dictionary<String, Any>){
                
                value = self.getParams(val as! Dictionary<String, Any>) as AnyObject!
            }else if (val is NSArray){
                value = self.getParamsFromArray(val as! NSArray) as AnyObject!
            }else if(val is Int){
                value = paramsDict[key] as! Int as AnyObject!
            }else{
                value = paramsDict[key] as! String as AnyObject!
            }
            
            
            parameters[key] = value as AnyObject
        }
        
        return parameters
    }
    
    func getParamsFromArray(_ paramsAry : NSArray) -> [String] {
        let swiftArray: [String] = paramsAry.flatMap({ $0 as? String })
        return swiftArray
    }
}


extension UIImage {
    func resizeWith(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWith(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
