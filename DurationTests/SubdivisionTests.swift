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

    func testDescription() {
        let s = Subdivision(value: 16)!
        XCTAssertEqual(s.description, "Subdivision: (value: 16, level: 2)")
    }
    
    func testInitLevel() {
        let values = [(1,8),(2,16),(3,32),(4,64),(5,128),(6,256),(7,512)]
        values.forEach {
            XCTAssertEqual(Subdivision(level: $0.0).level, $0.0)
            XCTAssertEqual(Subdivision(level: $0.0).value, $0.1)
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
            XCTAssertEqual(Subdivision(value: $0.1)!.value, $0.1)
        }
    }
    
    func testEquality() {
        let s1 = Subdivision(level: 2)
        let s2 = Subdivision(value: 16)
        XCTAssertEqual(s1, s2)
    }
    
    func testInequality() {
        let s1 = Subdivision(level: 1)
        let s2 = Subdivision(level: 2)
        XCTAssertNotEqual(s1, s2)
    }
    
    func testMultiply_1() {
        let s = Subdivision(value: 64)!
        let new = s * 1
        XCTAssertEqual(new, s)
    }
    
    func testMultiplyNil_5() {
        let s = Subdivision(value: 4)!
        let new = s * 5
        XCTAssertNil(new)
    }
    
    func testMultiplyPowerOfTwo() {
        let s = Subdivision(value: 2)!
        let new = (s * 8)!
        XCTAssertEqual(new.value, 16)
    }
    
    func testDivisionNil() {
        let s = Subdivision(value: 32)!
        let new = s / 5
        XCTAssertNil(new)
    }
    
    func testDivision_1() {
        let s = Subdivision(value: 32)!
        let new = (s / 1)!
        XCTAssertEqual(s, new)
    }
    
    func testDivision_4() {
        let s = Subdivision(value: 128)!
        let new = (s / 4)!
        XCTAssertEqual(new.value, 32)
    }
    
    func testMultiplyFloatNil() {
        let s = Subdivision(value: 4)!
        let new = s * 2.5
        XCTAssertNil(new)
    }
    
    func testMultiplyValid() {
        let s = Subdivision(value: 64)!
        let new = (s * 0.5)!
        XCTAssertEqual(new.value, 32)
    }
    
    func testDivideFloatNil() {
        let s = Subdivision(value: 32)!
        let new = s / 0.6234
        XCTAssertNil(new)
    }
    
    func testDivideValid() {
        let s = Subdivision(value: 128)!
        let new = (s / 0.25)!
        XCTAssertEqual(new.value, 512)
    }
}