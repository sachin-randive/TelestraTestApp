//
//  TelestraTestAppTests.swift
//  TelstraTestAppTests
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest
@testable import TelstraTestApp

class TelstraTestAppTests: XCTestCase {
    
    var testSession: URLSession!
    
    override func setUp() {
        super.setUp()
        testSession = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        testSession = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Asynchronous test: success fast, failure slow
    func testValidCallToGetHTTPStatusCode200() {
        // given
        let url = URL(string:TTAppConfig().authoriseBaseURL)
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = testSession.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 10)
    }


    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
