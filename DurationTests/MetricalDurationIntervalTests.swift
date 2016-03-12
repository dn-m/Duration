 //
//  MetricalDurationIntervalTests.swift
//  Duration
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import IntervalTools
@testable import Duration

class MetricalDurationIntervalTests: XCTestCase {
    
    func testBisectNil() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        XCTAssertNil(i.bisect(at: MetricalDuration(1,8)!))
    }
    
    func testBisectValid() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        let (a,b) = i.bisect(at: MetricalDuration(5,8)!)!
        XCTAssertEqual(a, MetricalDurationInterval((3,16),(5,8))!)
        XCTAssertEqual(b, MetricalDurationInterval((5,8),(9,8))!)
    }
    
    func testTrimStartNil() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        XCTAssertNil(i.trim(start: MetricalDuration(10,8)!))
    }
    
    func testTrimStartValid() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        let trimmed = i.trim(start: MetricalDuration(5,8)!)!
        XCTAssertEqual(trimmed, MetricalDurationInterval((5,8),(9,8))!)
    }
    
    func testTrimStopNil() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        XCTAssertNil(i.trim(stop: MetricalDuration(1,8)!))
    }
    
    func testTrimStopValid() {
        let i = MetricalDurationInterval(MetricalDuration(3,16)!, MetricalDuration(9,8)!)
        let trimmed = i.trim(stop: MetricalDuration(5,8)!)!
        XCTAssertEqual(trimmed, MetricalDurationInterval((3,16),(5,8))!)
    }
    
    func testUnionTransitive() {
        let i1 = MetricalDurationInterval((1,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(3,8))!
        XCTAssertEqual(i1.union(with: i2), i2.union(with: i1))
    }
    
    func testUnion() {
        let i1 = MetricalDurationInterval((2,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(3,8))!
        let union = MetricalDurationInterval((1,8),(4,8))!
        XCTAssertEqual(union, i1.union(with: i2))
    }
    
    func testContainsFalseLeft() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i = MetricalDurationInterval(start, stop)
        XCTAssertFalse(i.contains(start))
    }
    
    func testContainsFalseRight() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i = MetricalDurationInterval(start, stop)
        XCTAssertFalse(i.contains(stop))
    }
    
    func testContainsTrueMiddle() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i = MetricalDurationInterval(start, stop)
        let middle = MetricalDuration(5,8)!
        XCTAssert(i.contains(middle))
    }
    
    func testContainsFalseBefore() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i = MetricalDurationInterval(start, stop)
        let before = MetricalDuration(1,8)!
        XCTAssertFalse(i.contains(before))
    }
    
    func testContainsFalseAfter() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i = MetricalDurationInterval(start, stop)
        let after = MetricalDuration(10,8)!
        XCTAssertFalse(i.contains(after))
    }
    
    func testIntervalEquals() {
        let start = MetricalDuration(3,16)!
        let stop = MetricalDuration(9,8)!
        let i1 = MetricalDurationInterval(start, stop)
        let i2 = MetricalDurationInterval(start, stop)
        XCTAssert(i1.relationshipWith(i2) == .Equals)
    }
    
    func testIntervalPrecedes() {
        let i1 = MetricalDurationInterval((1,8),(2,8))!
        let i2 = MetricalDurationInterval((3,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .Precedes)
    }
    
    func testIntervalMeets() {
        let i1 = MetricalDurationInterval((1,8),(2,8))!
        let i2 = MetricalDurationInterval((2,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .Meets)
    }
    
    func testIntervalOverlaps() {
        let i1 = MetricalDurationInterval((1,8),(3,8))!
        let i2 = MetricalDurationInterval((2,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .Overlaps)
    }
    
    func testIntervalFinishedBy() {
        let i1 = MetricalDurationInterval((1,8),(4,8))!
        let i2 = MetricalDurationInterval((2,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .FinishedBy)
    }
    
    func testIntervalContains() {
        let i1 = MetricalDurationInterval((1,8),(4,8))!
        let i2 = MetricalDurationInterval((2,8),(3,8))!
        XCTAssert(i1.relationshipWith(i2) == .Contains)
    }
    
    func testIntervalStarts() {
        let i1 = MetricalDurationInterval((1,8),(3,8))!
        let i2 = MetricalDurationInterval((1,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .Starts)
    }
    
    func testIntervalStartedBy() {
        let i1 = MetricalDurationInterval((1,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(3,8))!
        XCTAssert(i1.relationshipWith(i2) == .StartedBy)
    }
    
    func testIntervalDuring() {
        let i1 = MetricalDurationInterval((2,8),(3,8))!
        let i2 = MetricalDurationInterval((1,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .During)
    }
    
    func testIntervalFinishes() {
        let i1 = MetricalDurationInterval((2,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(4,8))!
        XCTAssert(i1.relationshipWith(i2) == .Finishes)
    }
    
    func testIntervalOverlappedBy() {
        let i1 = MetricalDurationInterval((2,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(3,8))!
        XCTAssert(i1.relationshipWith(i2) == .OverlappedBy)
    }
    
    func testIntervalMetBy() {
        let i1 = MetricalDurationInterval((2,8),(3,8))!
        let i2 = MetricalDurationInterval((1,8),(2,8))!
        XCTAssert(i1.relationshipWith(i2) == .MetBy)
    }
    
    func testIntervalPrecededBy() {
        let i1 = MetricalDurationInterval((3,8),(4,8))!
        let i2 = MetricalDurationInterval((1,8),(2,8))!
        XCTAssert(i1.relationshipWith(i2) == .PrecededBy)
    }
}
