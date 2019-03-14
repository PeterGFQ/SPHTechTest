//
//  AnnuallyMobileDataUsage.swift
//  SPHTechTest
//
//  Created by Peter Guo on 13/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation

struct AnnuallyMobileDataUsage {
    
    typealias quarterlyVolumeElement = [String : Double]
    
    fileprivate var _year: Int?
    fileprivate var _volumeOfMobileData: Double?
    fileprivate var _quarterlyVolume: quarterlyVolumeElement?
    
    var year: Int?{
        get{
            return self._year
        }
        set(value){
            if(value == nil) { self._year = 0 }
            else { self._year = value }
        }
    }
    
    var volumeOfMobileData: Double?{
        get{
            return self._volumeOfMobileData
        }
        set(value){
            if(value == nil) { self._volumeOfMobileData = 0 }
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
