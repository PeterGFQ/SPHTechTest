//
//  DataMappingServices.swift
//  SPHTechTest
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class DataMappingServices {
    
    fileprivate static let dataMappingServices: DataMappingServices = DataMappingServices ()
    static func getInstance () -> DataMappingServices {
        return dataMappingServices
    }
    
    func mapToQuarterlyMobileDataUsages(json: Any?) -> [QuarterlyMobileDataUsage] {
        var qMDUs: [QuarterlyMobileDataUsage] = []
        guard let response = JSON(json!).dictionaryObject,
            let result = JSON(response["result"]!).dictionaryObject,
            let records = JSON(result["records"]!).array else {
            return qMDUs
        }
        
        for element in records {
            let qMDU = Mapper<QuarterlyMobileDataUsage>().map(JSONString: JSON(element).rawString()!)
            qMDUs.append(qMDU!)
        }
        
        return qMDUs
    }
    
    func mapToAnnuallyMobileDataUsage(json: Any?) -> [AnnuallyMobileDataUsage] {
        var aMDUs: [AnnuallyMobileDataUsage] = []
        guard let elements = JSON(json!).array else {
            return aMDUs
        }
        for element in elements {
            let aMDU = Mapper<AnnuallyMobileDataUsage>().map(JSONString: JSON(element).rawString()!)
            aMDUs.append(aMDU!)
        }
        
        return aMDUs
    }
    
    func mapFromQMDsUToAMDUs(qMDUs: [QuarterlyMobileDataUsage]) -> [AnnuallyMobileDataUsage] {
        var aMDUs: [AnnuallyMobileDataUsage] = []
        var count = 1
        var aMDU = AnnuallyMobileDataUsage()
        var volume = 0.0
        for (index, qMDU) in qMDUs.enumerated() {
            volume += Double(qMDU.volumeOfMobileData!)!
            aMDU.year = Int((qMDU.quarterOfYear?.substring(to: 4))!)
            aMDU.quarterlyVolume?.updateValue(qMDU.volumeOfMobileData!, forKey: qMDU.quarterOfYear!)
            count += 1
            if count == 5 || qMDUs.endIndex == (index + 1) {
                aMDU.volumeOfMobileData = String(volume)
                aMDUs.append(aMDU)
                aMDU = AnnuallyMobileDataUsage()
                count = 1
                volume = 0.0
            }
        }
        return aMDUs
    }
}
