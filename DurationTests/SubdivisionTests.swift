//
//  SubdivisionTests.swift
//  Duration
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Duration

class SubdivisionTests: XCTestCase {
    
    func testInitLevel() {
        let values = [(1,8),(2,16),(3,32),(4,64),(5,128),(6,256),(7,512)]
        values.forEach {
            XCTAssertEqual(Subdivision(level: $0.0).level, $0.0)
            XCTAssertEqual(Subdivision(level: $0.0), Subdivision($0.1))
        }
    }
    
    func testInitValueNilNegative() {
        XCTAssertNil(Subdivision(value: -16))
    }
    
    func testInitValueNilNotPowerOfTwo() {
        XCTAssertNil(Subdivision(value: 7))
    }
    
    func testInitValue() {
        let values = [(1,8),(2,16),(3,32),(4,64),(5,128),(6,256),(7,512)]
        values.forEach {
            XCTAssertEqual(Subdivision(value: $0.1)!.level, $0.0)
            XCTAssertEqual(Subdivision(value: $0.1)!, Subdivision($0.1))
        }
    }
}
