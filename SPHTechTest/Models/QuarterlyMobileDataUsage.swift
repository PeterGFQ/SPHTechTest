//
//  QuarterlyMobileDataUsage.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import ObjectMapper

struct QuarterlyMobileDataUsage : Mappable {
    
    fileprivate var _id: Int?
    fileprivate var _quarterOfYear: String?
    fileprivate var _volumeOfMobileData: Double?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        _id    <- map["_id"]
        _quarterOfYear    <- map["quarter"]
        _volumeOfMobileData    <- map["volume_of_mobile_data"]
    }
    
    var id: Int?{
        get{
            return self._id
        }
        set(value){
            if(value == nil) {self._id = 0}
            else {self._id = value}
        }
    }
    
    var quarterOfYear: String?{
        get{
            return self._quarterOfYear
        }
        set(value){
            if(value == nil) {self._quarterOfYear = ""}
            else {self._quarterOfYear = value}
        }
    }
    
    var volumeOfMobileData: Double?{
        get{
            return self._volumeOfMobileData
        }
        set(value){
            if(value == nil) {self._volumeOfMobileData = 0}
            else {self._volumeOfMobileData = value}
        }
    }
}
