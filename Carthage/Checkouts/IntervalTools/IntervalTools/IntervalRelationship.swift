//
//  IntervalRelationship.swift
//  IntervalTools
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Implementation of Allen's Interval Algebra
 */
public struct IntervalRelationship: OptionSetType {
    
    // MARK - Instance Properties
    
    public let rawValue: Int
    
    // MARK - Initializers
    
    /**
     Create an IntervalRelationship with `rawValue`.
     */
    public init(rawValue: Int) { self.rawValue = rawValue }
    
    // -- x precedes y
    // x -----
    // y        -----
    
    // MARK: - Cases
    
    public static var Precedes = IntervalRelationship(rawValue: 1)
    
    // -- x meets y
    // x -----
    // y      -----
    
    public static var Meets = IntervalRelationship(rawValue: 2)
    
    // x overlaps with y
    // x -----
    // y   ------
    
    public static var Overlaps = IntervalRelationship(rawValue: 4)
    
    // x is finished by y
    // x --------
    // y      ---
    
    public static var FinishedBy = IntervalRelationship(rawValue: 8)
    
    // x ?? y
    // x -----------
    // y     ----
    
    public static var Contains = IntervalRelationship(rawValue: 16)
    
    // x starts y
    // x -----
    // y ---------
    
    public static var Starts = IntervalRelationship(rawValue: 32)
    
    // x is equal to y
    // x --------
    // y --------
    
    public static var Equals = IntervalRelationship(rawValue: 64)
    
    // x is started by y
    // x --------
    // y ---
    
    public static var StartedBy = IntervalRelationship(rawValue: 128)
    
    // x during y
    // x     ----
    // y -----------
    
    public static var During = IntervalRelationship(rawValue: 256)
    
    // x finishes y
    // x      ---
    // y --------
    
    public static var Finishes = IntervalRelationship(rawValue: 512)
    
    // x is overlapped by y
    // x   ------
    // y -----
    
    public static var OverlappedBy = IntervalRelationship(rawValue: 1024)
    
    // x is met by y
    // x      -----
    // y -----
    
    public static var MetBy = IntervalRelationship(rawValue: 2048)
    
    // -- x takes place after y
    // x        -----
    // y -----
    
    public static var PrecededBy = IntervalRelationship(rawValue: 4096)
    
    public static var Intersects: IntervalRelationship = [
        .Overlaps,
        .FinishedBy,
        .Contains,
        .Starts,
        .Equals,
        .StartedBy,
        .During,
        .Finishes,
        .OverlappedBy
    ]
}