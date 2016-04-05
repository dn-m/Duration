//
//  DurationInterval.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import IntervalTools

/// TODO: conform to Interval when Interval has been updated
public struct DurationInterval: Interval {
    
    public let start: Duration
    public let stop: Duration
    public let span: Duration
    
    // TODO: ensure ordered
    public init(_ start: Duration, _ stop: Duration) {
        self.start = start
        self.stop = stop
        self.span = stop - start
    }
}

extension DurationInterval: Equatable { }

public func == (lhs: DurationInterval, rhs: DurationInterval) -> Bool {
    return lhs.start == rhs.start && lhs.stop == rhs.stop
}