//
//  DurationTests.swift
//  Duration
//
//  Created by James Bean on 7/2/17.
//
//

import XCTest
import Duration

class DurationTests: XCTestCase {

    func testSeconds() {
        let minute = Seconds(60)
        XCTAssertEqual(minute, 60)
    }
}
