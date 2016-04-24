//
//  Interval.swift
//  IntervalTools
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Closed interval between two values.
 */
public protocol Interval: Equatable {
    
    // MARK: - Associated Types
    
    /// Type of value defining the `start`, `stop`, and `span` values.
    associatedtype T: Comparable
    
    // MARK: - Instance Properties
    
    /// Start value.
    var start: T { get }
    
    /// Stop value.
    var stop: T { get }
    
    /// Span between `start` and `stop` values.
    var span: T { get }
    
    // MARK: - Initializers
    
    /// Create an `Interval` with start and stop values
    init(_ start: T, _ stop: T)
    
    // MARK: - Instance Methods
    
    /**
     - returns: `true` if `value > start && value < stop`. Otherwise `false`.
     */
    func contains(value: T) -> Bool
    
    /**
     - returns: `IntervalRelationship` between this `Interval` and another
     */
    func relationship(with interval: Self) -> IntervalRelationship
}

extension Interval {
    
    /**
     - returns: `true` if `value > start && value < stop`. Otherwise `false`.
     */
    public func contains(value: T) -> Bool {
        return value > start && value < stop
    }
    
    /**
     - returns: `IntervalRelationship` between this `Interval` and another
     */
    public func relationship(with interval: Self) -> IntervalRelationship {
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
}