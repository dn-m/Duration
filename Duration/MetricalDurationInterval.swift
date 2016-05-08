//
//  MetricalDurationInterval.swift
//  Duration
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import IntervalTools
import ArithmeticTools

/**
 Open interval between two `MetricalDuration` values.
 */
public struct MetricalDurationInterval: Interval {
    
    // MARK: - Type Properties
    
    public static let zero: MetricalDurationInterval = MetricalDurationInterval((0,8),(0,8))!
    
    // MARK: - Instance Properties
    
    /// `MetricalDuration` at start of interval.
    public let start: MetricalDuration
    
    /// `MetricalDuration` at stop of interval.
    public let stop: MetricalDuration
    
    /// The `MetricalDuration` between the `start` and `stop` `MetricalDuration` values.
    public let span: MetricalDuration
    
    // MARK: Intitializers
    
    /**
    Create a `MetricalDurationInterval` with two `MetricalDuration` values.
    */
    public init(_ start: MetricalDuration, _ stop: MetricalDuration) {
        (self.start, self.stop) = ordered(start, stop)
        self.span = stop - start
    }
    
    public init?(_ start: (Beats, Int), _ stop: (Beats, Int)) {
        guard let
            start = MetricalDuration(start.0, start.1),
            stop = MetricalDuration(stop.0, stop.1)
        else { return nil }
        self.start = start
        self.stop = stop
        self.span = stop - start
    }

    // MARK: Instance Methods

    /**
     - returns: `MetricalDurationInterval` spanning from the least `start` value of the given 
        `MetricalDurationInterval` values, to the greatest `stop` value of the given
        `MetricalDurationInterval` values
     */
    public func union(with interval: MetricalDurationInterval) -> MetricalDurationInterval {
        let points = [start, stop, interval.start, interval.stop].sort()
        return MetricalDurationInterval(points.first!, points.last!)
    }
    
    /**
     - returns: 2-tuple of `MetricalDurationInterval` values, as a result of bisecting a
        `MetricalDurationInterval` value. `nil` if given `duration` is not contained by 
        `MetricalDurationInterval`.
     */
    public func bisect(at duration: MetricalDuration)
        -> (MetricalDurationInterval, MetricalDurationInterval)?
    {
        guard contains(duration) else { return nil }
        let first = MetricalDurationInterval(start, duration)
        let second = MetricalDurationInterval(duration, stop)
        return (first, second)
    }
    
    /**
     - returns: `MetricalDurationInterval` with the same `stop` value, but with an adjusted
        `start` value. `nil` if given `duration` is not contained by `MetricalDurationInterval`
     */
    public func trim(start newStart: MetricalDuration) -> MetricalDurationInterval? {
        if newStart > stop { return nil }
        return MetricalDurationInterval(newStart, stop)
    }

    /**
     - returns: `MetricalDurationInterval` with the same `start` value, but with an adjusted
        `stop` value. `nil` if given `duration` is not contained by `MetricalDurationInterval`
     */
    public func trim(stop newStop: MetricalDuration) -> MetricalDurationInterval? {
        if newStop < start { return nil }
        return MetricalDurationInterval(start, newStop)
    }
}

extension MetricalDurationInterval: Equatable { }

public func == (lhs: MetricalDurationInterval, rhs: MetricalDurationInterval) -> Bool {
    return lhs.start == rhs.start && lhs.stop == rhs.stop
}
