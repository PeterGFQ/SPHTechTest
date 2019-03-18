//
//  UtilsTests.swift
//  SPHTechTestTests
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//

import XCTest
@testable import SPHTechTest

class UtilsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadUserDefaults()  {
        let value = Utils.loadUserDefaults(key: "hello")
        XCTAssert(value == "")
    }
    
    func testHexStringToUIColor() {
        let testCase1 = "#ffffffff"
        let result1 = Utils.hexStringToUIColor(hex: testCase1)
        let expResult1 = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        
        let testCase2 = "000000"
        let result2 = Utils.hexStringToUIColor(hex: testCase2)
        let expResult2 = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        
        let testCase3 = "00ff00"
        let result3 = Utils.hexStringToUIColor(hex: testCase3)
        let expResult3 = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0)
        

        XCTAssert(result1 == expResult1)
        XCTAssert(result2 == expResult2)
        XCTAssert(result3 != expResult3)
    }

}
