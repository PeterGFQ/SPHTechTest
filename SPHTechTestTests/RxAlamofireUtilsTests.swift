//
//  RxAlamofireUtilsTests.swift
//  SPHTechTestTests
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import XCTest
@testable import SPHTechTest

class RxAlamofireUtilsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetwithWrongParams() {
        let expectation = self.expectation(description: "Test API with wrong params")
        var requestQuery:[String:String] = [:]
        requestQuery.updateValue("a807b7ab-6cad-4aa6-87d0-e283a7353a0f", forKey: "resource_id")
        requestQuery.updateValue("offset", forKey: "55")
        //wrong params
        RxAlamofireUtils.init().get("https://data.gov.sg/api/action/datastore_search", requestQuery, TimeInterval(10), success: { (response, json) in
            XCTFail("Fail")
        }) { (exception) in
            XCTAssert((exception.error?.code)! >= 400)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10)
    }
    
    func testGetwithCorrectParams() {
        let expectation = self.expectation(description: "Test API with correct params")
        var requestQuery:[String:String] = [:]
        requestQuery.updateValue("a807b7ab-6cad-4aa6-87d0-e283a7353a0f", forKey: "resource_id")
        requestQuery.updateValue("55", forKey: "offset")
        //correct params
        RxAlamofireUtils.init().get("https://data.gov.sg/api/action/datastore_search", requestQuery, TimeInterval(10), success: { (response, json) in
            guard let response = response else{
                XCTFail("Error in response")
                return
            }
            XCTAssert(200..<300 ~= response.statusCode)
            expectation.fulfill()
        }) { (exception) in
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10)
    }
}
