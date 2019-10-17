//
//  APIServiceTests.swift
//  AppleMVCDemoTests
//
//  Created by Jason Chen on 2019/10/17.
//  Copyright © 2019 Jason Chen. All rights reserved.
//

import XCTest
@testable import AppleMVCDemo

class APIServiceTests: XCTestCase {
    
    var sut: APIService?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_fetch_popular_photos() {
        // Given a APIService
        let sut = self.sut!
        
        // When fetch popular photos
        let expect = XCTestExpectation(description: "callback")
        
        sut.fetchPopularPhoto(complete: { (success, photos, error) in
            expect.fulfill()
            XCTAssertEqual(photos.count, 20)
            for photo in photos {
                XCTAssertNil(photo.id)
            }
        })
        
        wait(for: [expect], timeout: 0.5)
    }
}
