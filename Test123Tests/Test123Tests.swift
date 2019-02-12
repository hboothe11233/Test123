//
//  Test123Tests.swift
//  Test123Tests
//
//  Created by Horatio Boothe on 8/3/18.
//  Copyright © 2018 Horatio Boothe. All rights reserved.
//

import XCTest
@testable import Test123

class Test123Tests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNames() {
        
        for offer in offers! {
            XCTAssertNotNil(offer.name)
        }
    }
    
    func testDescriptions(){
        for offer in offers! {
            XCTAssertNotNil(offer.description)
        }
    }
    
    func testCurrentValue(){
        for offer in offers! {
            XCTAssertNotNil(offer.currentValue)
        }
    }
    
    func testCurrentUrl(){
        for offer in offers! {
            if offer.id == "120330" || offer.id == "120331"{
               XCTAssertNil(offer.url, "\(offer.name) with ID \(offer.id) has nil value")
            }else{
                XCTAssertNotNil(offer.url)
            }
        }
    }
    
    func testTerms(){
        for offer in offers! {
            XCTAssertNotNil(offer.terms)
        }
    }
    
    func testId(){
        for offer in offers! {
            XCTAssertNotNil(offer.id)
        }
    }
    
    func testIsFavorite(){
        for offer in offers! {
            XCTAssertFalse(offer.isFavorite)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
