//
//  MetricalDurationTests.swift
//  Duration
//
//  Created by James Bean on 3/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Duration

class MetricalDurationTests: XCTestCase {

    func testInitNil() {
        XCTAssertNil(MetricalDuration(3,17))
    }
    
    func testEqual() {
        let d1 = MetricalDuration(3,16)
        let d2 = MetricalDuration(6,32)
        XCTAssertEqual(d1, d2)
    }
    
    func testMetricalDurationZero() {
        XCTAssertEqual(MetricalDuration.Zero, MetricalDuration(0,8)!)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_1_8() {
        let s = Subdivision(value: 8)!
        let total = MetricalDuration.totalSubdivision(
            withBeats: 1, andSubdivision: s
        )
        XCTAssertEqual(total, s)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_2_128() {
        let total = MetricalDuration.totalSubdivision(
            withBeats: 2, andSubdivision: Subdivision(value: 128)!
        )
        XCTAssertEqual(total, Subdivision(value: 64)!)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_4_16() {
        let total = MetricalDuration.totalSubdivision(
            withBeats: 4, andSubdivision: Subdivision(value: 16)!
        )
        XCTAssertEqual(total, Subdivision(value: 4)!)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_6_32() {
        let total = MetricalDuration.totalSubdivision(
            withBeats: 6, andSubdivision: Subdivision(value: 32)!
        )
        XCTAssertEqual(total, Subdivision(value: 16)!)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_7_64() {
        let total = MetricalDuration.totalSubdivision(
            withBeats: 7, andSubdivision: Subdivision(value: 64)!
        )
        XCTAssertEqual(total, Subdivision(value: 32)!)
    }
    
    func testTotalSubdivisionWithBeatsAndSubdivision_15_128() {
        let total = MetricalDuration.totalSubdivision(
            withBeats: 15, andSubdivision: Subdivision(value: 128)!
        )
        XCTAssertEqual(total, Subdivision(value: 32)!)
    }
    
    func testTotalSubdivisionInit() {
        let d = MetricalDuration(7,64)!
        XCTAssertEqual(d.totalSubdivision, Subdivision(value: 32)!)
    }
    
    func testInitFloatValueZero() {
        let d = MetricalDuration(floatValue: 0.0)
        XCTAssertEqual(d, MetricalDuration.Zero)
    }
    
    func testInitFloatValue_1_8() {
        let d = MetricalDuration(floatValue: 1)
        XCTAssertEqual(d, MetricalDuration(1,8)!)
    }
    
    func testInitFloatValue_3_16() {
        let d = MetricalDuration(floatValue: 1.5)
        XCTAssertEqual(d, MetricalDuration(3,16)!)
    }
    
    func testInitFloatValue_5_32() {
        let d = MetricalDuration(floatValue: 1.25)
        XCTAssertEqual(d, MetricalDuration(5,32)!)
    }
    
    func testIsReducedTrue_prime() {
        let d = MetricalDuration(13,8)!
        XCTAssert(d.isReduced)
    }
    
    func testIsReducedTrue_odd() {
        let d = MetricalDuration(15,8)!
        XCTAssert(d.isReduced)
    }
    
    func testIsReducedFalse_even() {
        let d = MetricalDuration(14,32)!
        XCTAssertFalse(d.isReduced)
    }
    
    func testReduce_alreadyReduced_1_8() {
        let d = MetricalDuration(1,8)!
        XCTAssertEqual(d, d.reduce())
    }
    
    func testReduce_alreadyReduced_5_32() {
        let d = MetricalDuration(5,32)!
        XCTAssertEqual(d, d.reduce())
    }
    
    func testReduce_14_128() {
        let d = MetricalDuration(14,128)!
        XCTAssertEqual(d.reduce(), MetricalDuration(7,64)!)
    }
    
    func testRespellToBeats_Equivalent() {
        let d = MetricalDuration(1,8)!
        let respelled = d.respell(withBeats: 1)!
        XCTAssertEqual(d.subdivision, respelled.subdivision)
    }
    
    func testRespellToBeatsNil() {
        let d = MetricalDuration(1,8)!
        let respelled = d.respell(withBeats: 3)
        XCTAssertNil(respelled)
    }
    
    func testRespellToBeats_PowerOfTwo_NewGreaterThanOld() {
        let d = MetricalDuration(2,8)!
        let respelled = d.respell(withBeats: 8)!
        XCTAssertEqual(respelled.subdivision, 32)
    }
    
    func testRespellToBeats_PowerOfTwo_NewLessThanOld() {
        let d = MetricalDuration(8,32)!
        let respelled = d.respell(withBeats: 2)!
        XCTAssertEqual(respelled.subdivision, 8)
    }
    
    func testRespellToSubdivision_Equivalent() {
        let d = MetricalDuration(1,8)!
        let respelled = d.respell(withSubdivision: 8)!
        XCTAssertEqual(respelled, d)
    }
    
    func testRespellToSubdivisionNil() {
        let d = MetricalDuration(1,8)!
        let respelled = d.respell(withSubdivision: 4)
        XCTAssertNil(respelled)
    }
    
    func testRespellToSubdivision_NewGreaterThanOld() {
        let d = MetricalDuration(4,64)!
        let respelled = d.respell(withSubdivision: 128)!
        XCTAssertEqual(respelled.beats, 8)
    }
    
    func testLeveled() {
        let a = MetricalDuration(5,32)!
        let b = MetricalDuration(13,64)!
        let (newA, newB) = leveled(a, b)
        XCTAssertEqual(newA.subdivision, 2048)
        XCTAssertEqual(newA.beats, 320)
        XCTAssertEqual(newB.subdivision, 2048)
        XCTAssertEqual(newB.beats, 416)
    }
    
    func testAreLevelFalse() {
        let a = MetricalDuration(5,32)!
        let b = MetricalDuration(13,128)!
        XCTAssertFalse(areLevel(a, b))
    }
    
    func testAreLevelTrue() {
        XCTAssert(areLevel(MetricalDuration(19,64)!, MetricalDuration(19,64)!))
    }
    
    func testAreReducedFalse() {
        let a = MetricalDuration(20,64)!
        let b = MetricalDuration(10,32)!
        XCTAssertFalse(areReduced(a,b))
    }
    
    func testAreReducedTrue() {
        let a = MetricalDuration(10,64)!
        let b = MetricalDuration(5,32)!
        XCTAssert(areReduced(a,b))
    }
    
    func testReduceHomogeneous() {
        let a = MetricalDuration(20,32)!
        let b = MetricalDuration(10,32)!
        let (newA, newB) = reduced(a,b)
        XCTAssertEqual(newA.beats, 10)
        XCTAssertEqual(newA.subdivision, 16)
        XCTAssertEqual(newB.beats, 5)
        XCTAssertEqual(newB.subdivision, 16)
    }
    
    func testReduceHeterogeneous() {
        let a = MetricalDuration(10,32)!
        let b = MetricalDuration(30,128)!
        let (newA, newB) = reduced(a,b)
        XCTAssertEqual(newA.beats, 20)
        XCTAssertEqual(newA.subdivision, 64)
        XCTAssertEqual(newB.beats, 15)
        XCTAssertEqual(newB.subdivision, 64)
    }
}
