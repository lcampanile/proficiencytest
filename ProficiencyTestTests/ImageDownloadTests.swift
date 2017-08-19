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

class ImageDownloadTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDownloadImageAsync() {
        
        let expect = expectation(description: "Waiting for image to be downloaded...")
        
        let url = URL(string: "https://dummyimage.com/wideskyscraper")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            XCTAssertNil(error, error!.localizedDescription)
            XCTAssertNotNil(data, "API did not return any data")
            XCTAssertNotNil(response, "Server did not respond")
            
            let image = UIImage(data: data!)
            XCTAssertNotNil(image, "Data returned from \(url) is not a valid image")
            
            expect.fulfill()
        }
        
        task.resume()
        waitForExpectations(timeout: Config.API.acceptabledTimeoutPolicy) { error in
            if let error = error {
                XCTFail("Image download timed out with error: \(error)")
            }
        }
    }
}
