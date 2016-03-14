//
//  MetricalDurationInterval.swift
//  Duration
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import IntervalTools

/**
 Open interval between two `MetricalDuration` values.
 */
public struct MetricalDurationInterval: Interval {
    
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
        self.start = start
        self.stop = stop
        self.span = stop - start
    }
    
    public init?(_ start: (Int, Int), _ stop: (Int, Int)) {
        guard let
            start = MetricalDuration(start.0, start.1),
            stop = MetricalDuration(stop.0, stop.1)
        else { return nil }
        self.start = start
        self.stop = stop
        self.span = stop - start
    }
    
    /**
     - returns: If `duration` is contained by `MetricalDurationInterval`.
        Left- and right-closed.
     */
    public func contains(value: MetricalDuration) -> Bool {
        return value > start && value < stop
    }

    // MARK: Instance Methods
    
    /**    
    - returns: `IntervalRelationship` with another `MetricalDurationInterval`
    */
    public func relationship(with interval: MetricalDurationInterval) -> IntervalRelationship {
        if stop < interval.start { return .Precedes }
        else if stop == interval.start { return .Meets }
        else if start < interval.start && interval.contains(stop) { return .Overlaps }
        else if stop == interval.stop && contains(interval.start) { return .FinishedBy }
        else if contains(interval.start) && contains(interval.stop) { return .Contains }
        else if start == interval.start && interval.contains(stop) { return .Starts }
        else if start == interval.start && contains(interval.stop) { return .StartedBy }
        else if interval.contains(start) && interval.contains(stop) { return .During }
        else if stop == interval.stop && interval.contains(start) { return .Finishes }
        else if stop > interval.stop && interval.contains(start) { return .OverlappedBy }
        else if start == interval.stop { return .MetBy }
        else if start > interval.stop { return .PrecededBy }
        return .Equals
    }
    
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