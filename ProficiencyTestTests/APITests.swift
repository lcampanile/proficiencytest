//
//  APITests.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation
import UIKit
import XCTest
@testable import ProficiencyTest

class APITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testContactEndpointItems() {
        
        let expect = expectation(description: "Waiting for internet call to be made...")

        let url = URL(string: Config.API.source + "/bins/m47pd")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNil(error, error!.localizedDescription)
            XCTAssertNotNil(data, "API did not return any data")
            XCTAssertNotNil(response, "Server did not respond")
            
            expect.fulfill()
        }
        
        task.resume()
        waitForExpectations(timeout: Config.API.acceptabledTimeoutPolicy) { error in
            if let error = error {
                XCTFail("Internet call timed out with error: \(error)")
            }
        }
    }
    
    func testGetItemsProvider() {
        
        let expect = expectation(description: "Waiting for download of list of items via data provider...")
        
        DataProvider.getItems { (items, error) in
            
            if error != nil {
                
                XCTAssertNotEqual(error!.type!, DataProviderErrorType.internet, "An error occured while trying to contact server: \(error!.errorDescription ?? "No description")")
                XCTAssertNotEqual(error!.type!, DataProviderErrorType.dataNotFound, error!.errorDescription ?? "API for listing items returned empty JSON")
                XCTAssertNotEqual(error!.type!, DataProviderErrorType.noValidFormat, error!.errorDescription ?? "API for listing items returned an bad formatted JSON.")
            }
            else {
                
                XCTAssertNotNil(items, "DataProvider did not return any data.")
                XCTAssertTrue(items! is [HomeViewModel], "DataProvider returned wrong type of data. Expected: [HomeViewModel]")
            }
            
            expect.fulfill()
        }
        
        waitForExpectations(timeout: Config.API.acceptabledTimeoutPolicy) { error in
            if let error = error {
                XCTFail("Download of items timed out with error: \(error)")
            }
        }
    }
    
    func testGetItems() {
        
        let expect = expectation(description: "Waiting for download of items...")

        API.getItems { (items, error) in
            
            XCTAssertNil(error, error!)
            XCTAssertNotNil(items, "No items were returned")
            XCTAssertNotEqual(items!.count, 0, "Array of items returned is empty")
            expect.fulfill()
        }
        
        waitForExpectations(timeout: Config.API.acceptabledTimeoutPolicy) { error in
            if let error = error {
                XCTFail("Download of items timed out with error: \(error)")
            }
        }
    }
}
