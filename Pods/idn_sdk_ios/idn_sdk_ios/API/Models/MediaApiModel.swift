//
//  MediaApiModel.swift
//  idn_app_ios
//
//  Created by Afsarunnisa on 10/5/16.
//  Copyright © 2016 Afsarunnisa. All rights reserved.
//


import Foundation

@objc open class MediaApiModel:NSObject {
    // MARK: Properties
    open var mediaExtension : String = ""
    open var supportedsizes : String = ""
    
    open var mediaFileDetailsList : Array<Any>!
}
