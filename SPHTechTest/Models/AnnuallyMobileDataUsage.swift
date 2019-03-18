//
//  AnnuallyMobileDataUsage.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import ObjectMapper

struct AnnuallyMobileDataUsage : Mappable {
    
    typealias quarterlyVolumeElement = [String : String]
    
    fileprivate var _year: Int?
    fileprivate var _volumeOfMobileData: String?
    fileprivate var _quarterlyVolume: quarterlyVolumeElement?
    
    init() {
        _volumeOfMobileData = "0"
        _quarterlyVolume = quarterlyVolumeElement()
        _quarterlyVolume?.removeAll()
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        _year    <- map["_year"]
        _volumeOfMobileData    <- map["_volumeOfMobileData"]
        _quarterlyVolume    <- map["_quarterlyVolume"]
    }
    
    var year: Int?{
        get{
            return self._year
        }
        set(value){
            if(value == nil) { self._year = 0 }
            else { self._year = value }
        }
    }
    
    var volumeOfMobileData: String?{
        get{
            return self._volumeOfMobileData
        }
        set(value){
            if(value == nil) { self._volumeOfMobileData = "0" }
            else { self._volumeOfMobileData = value }
        }
    }
    
    var quarterlyVolume: quarterlyVolumeElement? {
        get{
            return self._quarterlyVolume
        }
        set(value){
            if(value == nil) { self._quarterlyVolume = quarterlyVolumeElement() }
            else { self._quarterlyVolume = value }
        }
    }

}
