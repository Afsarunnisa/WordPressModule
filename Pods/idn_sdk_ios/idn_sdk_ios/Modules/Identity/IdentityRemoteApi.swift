//
//  IdentityRemoteApi.swift
//  iOS_IDS_SDK_Test
//
//  Created by Afsarunnisa on 9/20/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//

import Foundation


open class IdentityRemoteApi  {
    
    let baseIdentityUrl : String = "api/identity/v0"
    let baseCoreUrl : String = "api/core/v0"
    
    let tokenUrl : String = "oauth/token"
    
    
    var loginUrl : String = ""
    var signupUrl : String = ""
    var socailConnectUrl : String = ""
    var authorizeUrl : String = ""
    var profileUrl : String = ""
    var forgotUrl : String = ""
    var changePasswordUrl : String = ""
    var logoutUrl : String = ""
    var socialLoginUrl : String = ""
    
    var getModulesUrl : String = ""
    
    var connectService : String = ""
    var authorizeService : String = ""
    var loginService : String = ""
    
    let networkAPI : NetworkApi!
    
    var apiContext : IdsIosApiContext!
    
    let clientTokenheaders : [String: String]
    //    let userTokenheaders : [String: String]
    
    
    init(httpClient: AnyObject) {
        
        apiContext = AbstractApiContext.get("app") as! IdsIosApiContext
        
        let clientTokenModel : TokenApiModel = apiContext.getClientToken() as! TokenApiModel
        let clientToken  = clientTokenModel.access_token
        
        
        
        clientTokenheaders = [
            "Authorization": "Bearer \(clientToken)"
        ]
        
        
        networkAPI = NetworkApi()
        
        
        loginUrl = "\(baseIdentityUrl)/auth/login"
        signupUrl = "\(baseIdentityUrl)/users/signup"
        socailConnectUrl = "\(baseIdentityUrl)/auth/social"
        authorizeUrl = "\(baseIdentityUrl)/auth/social/\(connectService)/authorize"
        profileUrl = "\(baseIdentityUrl)/users"
        forgotUrl = "\(baseIdentityUrl)/auth/forgotPassword"
        
        changePasswordUrl = "\(baseIdentityUrl)/auth/changePassword"
        logoutUrl = "\(baseIdentityUrl)/auth/logout"
        
        socialLoginUrl = "\(baseIdentityUrl)/auth/social/\(loginService)/login"
        
        getModulesUrl = "\(baseCoreUrl)/tenants/"
    }
    
    
    func login(_ loginDetails : LoginModel, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let loginDict : Dictionary = LoginModel().getLoginDict(login: loginDetails)
        
        let hostUrl : String = apiContext.getHost("app")
        let connectUrl = "\(hostUrl)\(loginUrl)"
        
        
        
        networkAPI.postWithEncode(connectUrl, paramsDict: loginDict, headers: clientTokenheaders, completionHandler: completionHandler)
    }
    
    
    func signUp(_ signUpDetails : SignUpModel, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        
        let signUpDict : Dictionary = SignUpModel().getSignUpDict(signUp: signUpDetails)
        
        let hostUrl : String = apiContext.getHost("app")
        let connectUrl = "\(hostUrl)\(signupUrl)"
        
        networkAPI.postWithEncode(connectUrl, paramsDict: signUpDict, headers: clientTokenheaders, completionHandler: completionHandler)
    }
    
    
    func socialWebLogin(socialType : String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let hostUrl : String = apiContext.getHost("app")
        
        let connectUrl = "\(hostUrl)\(socailConnectUrl)/\(socialType)/login"
        
        
        
        networkAPI.get(connectUrl, paramsDict: Dictionary(), headers: clientTokenheaders, completionHandler: completionHandler)
        
    }
    
    
    
    func socialLogin(_ socialLoginDict : Dictionary<String, Any>,socialType : String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        let hostUrl : String = apiContext.getHost("app")
        
        let connectUrl = "\(hostUrl)\(socailConnectUrl)/\(socialType)/connect"
        networkAPI.postWithEncode(connectUrl, paramsDict: socialLoginDict, headers: clientTokenheaders, completionHandler: completionHandler)
    }
    
    
    func logOut(_ completionHandler: @escaping (AnyObject?,Int, NSError?) -> ()){
        
        let hostUrl : String = apiContext.getHost("app")
        
        let connectUrl = "\(hostUrl)\(logoutUrl)"
        
        let userTokenModel : TokenApiModel = apiContext.getUserToken("identity") as! TokenApiModel
        let userToken  = userTokenModel.access_token
        
        let userTokenheaders = [
            "Authorization": "Bearer \(userToken)"
        ]
        
        networkAPI.get(connectUrl, paramsDict: Dictionary(), headers: userTokenheaders, completionHandler: completionHandler)
    }
    
    
    func getProfile(_ userID: String,completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        
        let hostUrl : String = apiContext.getHost("app")
        
        let url : String = "\(hostUrl)\(profileUrl)/\(userID)"
        
        let userTokenModel : TokenApiModel = apiContext.getUserToken("identity") as! TokenApiModel
        let userToken  = userTokenModel.access_token
        
        let userTokenheaders = [
            "Authorization": "Bearer \(userToken)"
        ]
        
        networkAPI.get(url, paramsDict: Dictionary(), headers: userTokenheaders, completionHandler: completionHandler)
    }
    
    
    func updateProfile(_ profileDetails : Dictionary<String, Any>,userID : String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        
        let hostUrl : String = apiContext.getHost("app")
        
        let url : String = "\(hostUrl)\(profileUrl)/\(userID)"
        
        let userTokenModel : TokenApiModel = apiContext.getUserToken("identity") as! TokenApiModel
        let userToken  = userTokenModel.access_token
        
        let userTokenheaders = [
            "Authorization": "Bearer \(userToken)"
        ]
        
        
        networkAPI.putWithEncode(url, paramsDict: profileDetails, headers: userTokenheaders, completionHandler: completionHandler)
    }
    
    
    func changePassword(_ changePswDetails : Dictionary<String, Any>, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        
        let hostUrl : String = apiContext.getHost("app")
        
        let url : String = "\(hostUrl)\(changePasswordUrl)"
        
        let userTokenModel : TokenApiModel = apiContext.getUserToken("identity") as! TokenApiModel
        let userToken  = userTokenModel.access_token
        
        let userTokenheaders = [
            "Authorization": "Bearer \(userToken)"
        ]
        
        networkAPI.postWithEncode(url, paramsDict: changePswDetails, headers: userTokenheaders, completionHandler: completionHandler)
    }
    
    func forgotPassword(_ forgotPswDetails : Dictionary<String, Any>, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()) {
        
        let hostUrl : String = apiContext.getHost("app")
        
        let url : String = "\(hostUrl)\(forgotUrl)"
        
        networkAPI.postWithEncode(url, paramsDict: forgotPswDetails, headers: clientTokenheaders, completionHandler: completionHandler)
    }
    
    
    func getModules(tenantID : String, completionHandler: @escaping (AnyObject?, Int, NSError?) -> ()){
        
        let hostUrl : String = apiContext.getHost("app")
        
        let url : String = "\(hostUrl)(getModulesUrl)\(tenantID)/modules/subscribed"
        
        networkAPI.get(url, paramsDict: Dictionary(), headers: clientTokenheaders, completionHandler: completionHandler)
        
    }
}
