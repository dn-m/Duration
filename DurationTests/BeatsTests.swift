//
//  BeatsTests.swift
//  Duration
//
//  Created by James Bean on 3/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
@testable import Duration

class BeatsTests: XCTestCase {

    func testDescription() {
        let b = Beats(amount: 5)
        XCTAssertEqual(b.description, "Beats: (amount: 5)")
    }
}