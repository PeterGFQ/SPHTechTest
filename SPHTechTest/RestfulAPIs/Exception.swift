//
//  Exception.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit

class Exception {
    
    public enum Status: String {
        //use for handle unexpected case
        case UnexpectedError = "UnexpectedError"
        case UmptyResponseBody = "UmptyResponseBody"
        case NetworkNotAvailable = "NetworkNotAvailable"
        
        case Unauthorized = "Unauthorized"
        case Forbidden = "Forbidden"
        case NotFound = "NotFound"
        case DataNotAccept = "DataNotAccept"
        case InternalServerError = "InternalServerError"
        
    }
    
    public enum Code: Int {
        //use for handle unexpected case
        case UnexpectedError = 1000
        case UmptyResponseBody = 2000
        case NetworkNotAvailable = 3000
        
        case Unauthorized = 401
        case NotFound = 404
        case DataNotAccept = 406
        case Forbidden = 408
        case InternalServerError = 500
    }
    
    fileprivate var _error: NSError?
    
    init(error:NSError){
        self.error = error.copy() as? NSError
    }
    
    init(code:Int, message:String) {
        let errorInfo: [String : Any] = ["message" :  message as Any]
        self._error = NSError(domain: "", code: code, userInfo: errorInfo)
    }
    
    init(code:Int,key:String,message:String){
        
        let errorInfo: [String : Any] =
            [
                NSLocalizedDescriptionKey as String :  NSLocalizedString(key, value: message, comment: "") as Any,
                NSLocalizedFailureReasonErrorKey as String : NSLocalizedString(key, value: key, comment: "") as Any
        ]
        self._error = NSError(domain: "", code: code, userInfo: errorInfo)
    }
    
    var error: NSError?{
        get{
            return self._error
        }
        set(value){
            self._error = value
        }
    }
}
