//
//  RolesApiModel.swift
//  Pods
//
//  Created by Afsarunnisa on 12/23/16.
//
//

import Foundation

@objc open class RolesApiModel:NSObject {
    // MARK: Properties
    open var uRoleName : String = ""
    open var displayName : String = ""
    open var roleDescription : String = ""
    
    open var authorities : NSArray!
}
