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
    
    associatedtype T = Comparable
    
    /// Start value.
    var start: T { get }
    
    /// Stop value.
    var stop: T { get }
    
    /// Span between `start` and `stop` values.
    var span: T { get }
    
    /**
     - returns: `true` if `value > start && value < stop`. Otherwise `false`.
     */
    func contains(value: T) -> Bool
    
    /**
     - returns: `IntervalRelationship` between this `Interval` and another
     */
    func relationship(with interval: Self) -> IntervalRelationship
}
