//
//  IssueTrackerTests.swift
//  IssueTrackerTests
//
//  Created by a1111 on 2020/10/27.
//

import XCTest
@testable import IssueTracker

class IssueTrackerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample2() throws {
        print(UserInfo.shared.isAllInfoExisted())
    }

    func testExample() throws {
        
        let dic = ["secret_code": "abc", "client_id": "def"]
        
        let result = dic.encode()
        guard let firstLetter = result.first, firstLetter == "?" else {
            XCTAssertFalse(true)
            return
        }
        
        let strArray = result.dropFirst(1).components(separatedBy: "&")
        
        var dic2 = [String: String]()
        
        for str in strArray {
            let subStr = str.components(separatedBy: "=")
            dic2[subStr[0]] = subStr[1]
        }
        
        XCTAssertTrue(dic == dic2)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
