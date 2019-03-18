//
//  NetworkManagerTests.swift
//  SPHTechTestTests
//
//  Created by Peter Guo on 18/3/19.
//  Copyright © 2019 Peter Guo. All rights reserved.
//


import XCTest
@testable import SPHTechTest
import Foundation
import SystemConfiguration

class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testIsConnectedToNetwork() {
        let condition = NetworkManager.sharedInstance.isConnectedToNetwork()
        if condition{
            XCTAssertEqual(condition, true, "Internet checking is wrong")
        }else{
            XCTAssertEqual(condition, false, "Internet checking is wrong")
        }
    }
}

