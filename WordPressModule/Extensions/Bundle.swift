//
//  Bundle.swift
//  WordpressModule
//
//  Created by Afsarunnisa on 06/02/2017.
//  Copyright © 2017 Afsarunnisa. All rights reserved.
//

import Foundation
public extension Bundle {
    
    /**
     Gets the contents of the specified file.
     
     - parameter fileName: Name of file to retrieve contents from.
     - parameter bundle: Bundle where defaults reside.
     - parameter encoding: Encoding of string from file.
     
     - returns: Contents of file.
     */
    static func stringOfFile(_ fileName: String, inDirectory: String? = nil, bundle: Bundle? = nil, encoding: String.Encoding = String.Encoding.utf8) -> String? {
        guard let resourcePath = (bundle ?? Bundle.main).path(forResource: fileName, ofType: nil, inDirectory: inDirectory) else { return nil }
        return try? String(contentsOfFile: resourcePath, encoding: encoding)
    }
}
