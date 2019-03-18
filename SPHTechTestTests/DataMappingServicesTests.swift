//
//  DataMappingServicesTests.swift
//  SPHTechTestTests
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import XCTest
@testable import SPHTechTest

class DataMappingServicesTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMapToQuarterlyMobileDataUsages() {
        let testData1 = "{}"
        let result1 = DataMappingServices.getInstance().mapToQuarterlyMobileDataUsages(json: testData1)
        XCTAssertEqual(result1.count ,0, "MapToQuarterlyMobileDataUsages is wrong")
        let testData2 = "{\"success\": true, \"result\": {\"resource_id\": \"a807b7ab-6cad-4aa6-87d0-e283a7353a0f\", \"fields\": [{\"type\": \"int4\", \"id\": \"_id\"}, {\"type\": \"text\", \"id\": \"quarter\"}, {\"type\": \"numeric\", \"id\": \"volume_of_mobile_data\"}], \"records\": [{\"volume_of_mobile_data\": \"18.47368\", \"quarter\": \"2018-Q2\", \"_id\": 56}], \"offset\": 55, \"total\": 56}}"

        let result2 = DataMappingServices.getInstance().mapToQuarterlyMobileDataUsages(json: jsonSerialization(str: testData2))
        XCTAssert(result2.count == 1)
    }
    
    //todo
    func testMapToAnnuallyMobileDataUsage(){
        
    }
    
    //todo
    func testMapFromQMDsUToAMDUsTest(){
        
    }
    
    fileprivate func jsonSerialization(str: String) -> Any?{
        let data = str.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? Any?
            {
                return jsonArray
            }
        } catch let error as NSError {
            print(error)
        }
        return "{}"
    }
}
