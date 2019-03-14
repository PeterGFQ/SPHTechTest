//
//  RxAlamofireUtils.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import SwiftyJSON
import RxSwift

class RxAlamofireUtils {
    
    fileprivate static let rxAlamofireUtils: RxAlamofireUtils = RxAlamofireUtils ()
    fileprivate static let TIMEOUT: TimeInterval = TimeInterval(10)
    
    typealias success = (_ response: HTTPURLResponse?, _ result: Any?) -> Void
    typealias failure = (_ exception: Exception) -> Void
    
    static func getInstance () -> RxAlamofireUtils {
        return rxAlamofireUtils
    }
    
    static func getTimeOut() -> TimeInterval{
        return TIMEOUT
    }
    
    func get(_ apiURL: String,_ params: [String:Any]?, _ timeout: TimeInterval, success: @escaping success, failure: @escaping failure) {
        
        if !NetworkManager.sharedInstance.isConnectedToNetwork() {
            failure(Exception(code: Exception.Code.NetworkNotAvailable.rawValue, message: "Network is not avaiable, please try again later"))
            return
        }
        
        _ = RxAlamofire
            .requestJSON(.get, apiURL, parameters: params, encoding: URLEncoding.default, headers: ["content-type" : "application/json"])
            .timeout(timeout, scheduler: MainScheduler.instance)
            .subscribeOn(ConcurrentMainScheduler.instance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (response,json) in
                if 200..<300 ~= response.statusCode
                {
                    success(response, json)
                }
                else {
                    if let errorData = (JSON(json).dictionaryObject) {
                        failure(Exception(code: response.statusCode, message: errorData["message"] as! String))
                    }else{
                        failure(Exception(code: response.statusCode, message: Exception.Status.UmptyResponseBody.rawValue))
                    }
                }
            }, onError: { (error) in
                if let error = error as? RxError{
                    if error.debugDescription == "Sequence timeout." {
                        print(error)
                    }
                    failure(Exception(code: Exception.Code.UnexpectedError.rawValue, message: error.debugDescription))
                    return
                }
                if let error = error as? AFError {
                    failure(Exception(code: error.responseCode ?? Exception.Code.UnexpectedError.rawValue, message: error.localizedDescription))
                }
                failure(Exception(code: Exception.Code.UnexpectedError.rawValue, message: error.localizedDescription))
            })
        //            .disposed(by: DisposeBag())
    }
}
