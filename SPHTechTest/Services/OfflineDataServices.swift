//
//  OfflineDataServices.swift
//  SPHTechTest
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import Foundation

class OfflineDataServices {
    fileprivate static let offlineDataServices: OfflineDataServices = OfflineDataServices ()
    static func getInstance () -> OfflineDataServices {
        return offlineDataServices
    }
    
    func writeDataToJsonFile(datas: [AnnuallyMobileDataUsage]) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("AMBUs.json")
        
        guard let stream = OutputStream(toFileAtPath: fileUrl.path, append: false) else { return }
        stream.open()
        defer {
            stream.close()
        }
        
        var error: NSError?
        JSONSerialization.writeJSONObject(datas.toJSON(), to: stream, options: [], error: &error)
        
        if let error = error {
            print(error)
        }
    }
    
    func readFromJsonFile() -> [AnnuallyMobileDataUsage] {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return []}
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("AMBUs.json")
        
        guard let stream = InputStream(url: fileUrl) else { return []}
        stream.open()
        defer {
            stream.close()
        }
        
        do {
            guard let aMBUs = try JSONSerialization.jsonObject(with: stream, options: []) as Any? else { return []}
            return DataMappingServices.getInstance().mapToAnnuallyMobileDataUsage(json: aMBUs)
        } catch {
            print(error)
        }
        return []
    }
}
