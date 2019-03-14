//
//  RestfulServices.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import ObjectMapper

class RestfulServices {
    
    fileprivate let KEY_RESOURCE_ID = "resource_id"
    fileprivate let KEY_OFFSET = "offset"
    fileprivate let RESOURCE_ID = "a807b7ab-6cad-4aa6-87d0-e283a7353a0f"

    fileprivate static let restfulServices: RestfulServices = RestfulServices ()
    fileprivate let BASE_API_URL = "https://data.gov.sg/api/action/datastore_search"
    typealias failure = (_ exception: Exception) -> Void

    static func getInstance () -> RestfulServices {
        return restfulServices
    }

    //https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&offset=14
    typealias fetchDataCompletionHandler = (_ datas: [QuarterlyMobileDataUsage]) -> Void
    func fetchData(fetchDataCompletionHandler: @escaping fetchDataCompletionHandler, failure: @escaping failure){
        var requestQuery:[String:String] = [:]
        requestQuery.updateValue(RESOURCE_ID, forKey: KEY_RESOURCE_ID)
        requestQuery.updateValue("14", forKey: KEY_OFFSET)
        RxAlamofireUtils.getInstance().get(BASE_API_URL, requestQuery, RxAlamofireUtils.getTimeOut(), success: { (response, json) in
           //todo mapping data
        }, failure: failure)
    }
}
