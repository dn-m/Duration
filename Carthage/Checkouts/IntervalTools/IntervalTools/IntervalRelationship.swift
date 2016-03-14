//
//  IntervalRelationship.swift
//  IntervalTools
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Implementation of 
    [Allen's Interval Algebra](https://en.wikipedia.org/wiki/Allen%27s_interval_algebra).
 
 ## Background
 
 From [Thomas A. Alspaugh](http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html#Allen1983-mkti):
 > In 1983 James F. Allen published a paper in which he proposed thirteen basic relations 
    between time intervals that are **distinct**, **exhaustive**, and **qualitative**.
 
 > - **Distinct** because no pair of definite intervals can be related by 
    more than one of the relationships
 > - **Exhaustive** because any pair of definite intervals are described by 
    one of the relations
 > - **Qualitative** (rather than quantitative) because no numeric time spans are considered
 
 The naming conventions used in this implementation are those of 
    [Allen](https://en.wikipedia.org/wiki/James_F._Allen), refined by 
    [Krokhin et al.](http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html#Allen1983-mkti).
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
    
    /**
    `a` precedes `b`.
    */
    public static var Precedes = IntervalRelationship(rawValue: 1)
    
    // -- x meets y
    // x -----
    // y      -----
    
    /**
    `a` meets `b`.
    */
    public static var Meets = IntervalRelationship(rawValue: 2)
    
    // x overlaps with y
    // x -----
    // y   ------
    
    /**
    `a` overlaps `b`.
    */
    public static var Overlaps = IntervalRelationship(rawValue: 4)
    
    // x is finished by y
    // x --------
    // y      ---
    
    /**
    `a` is finished by `b`.
    */
    public static var FinishedBy = IntervalRelationship(rawValue: 8)
    
    // x ?? y
    // x -----------
    // y     ----
    
    /**
    `a` contains `b`.
    */
    public static var Contains = IntervalRelationship(rawValue: 16)
    
    // x starts y
    // x -----
    // y ---------
    
    /**
    `a` starts `b`.
    */
    public static var Starts = IntervalRelationship(rawValue: 32)
    
    // x is equal to y
    // x --------
    // y --------
    
    /**
    `a` equals `b`.
    */
    public static var Equals = IntervalRelationship(rawValue: 64)
    
    // x is started by y
    // x --------
    // y ---
    
    /**
    `a` started by `b`.
    */
    public static var StartedBy = IntervalRelationship(rawValue: 128)
    
    // x during y
    // x     ----
    // y -----------
    
    /**
    `a` is during `b`.
    */
    public static var During = IntervalRelationship(rawValue: 256)
    
    // x finishes y
    // x      ---
    // y --------
    
    /**
    `a` finishes `b`.
    */
    public static var Finishes = IntervalRelationship(rawValue: 512)
    
    // x is overlapped by y
    // x   ------
    // y -----
    
    /**
    `a` is overlapped by `b`.
    */
    public static var OverlappedBy = IntervalRelationship(rawValue: 1024)
    
    // x is met by y
    // x      -----
    // y -----
    
    /**
    `a` is met by `b`.
    */
    public static var MetBy = IntervalRelationship(rawValue: 2048)
    
    // -- x takes place after y
    // x        -----
    // y -----
    
    /**
    `a` is preceded by `b`.
    */
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