//
//  Subdivision.swift
//  Duration
//
//  Created by James Bean on 3/2/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArithmeticTools

/**
 Subdivision of `MetricalDuration`.
 */
public typealias Subdivision = Int

public extension Subdivision {
    
    // MARK: - Instance Properties
    
    /// Positive integer value analogous to the amount of beams in graphical representation.
    public var level: Int { return Int(log(Double(self))/log(2)) - 2 }
    
    // MARK: - Initializers
    
    /**
    Create a Subvisiion with a value.
    
    - parameter value: Power-of-two value of the subdivision (e.g., 4, 8, 16, 32, etc.)
    
    - returns: Initialized Subdivision structure, if possible. Returns `nil` if value 
        is not greater than 0, or a power-of-two
    */
    public init?(value: Int) {
        guard value.isPowerOfTwo else { return nil }
        self = value
    }
    
    /**
     Create a Subdivision with a level.
     
     - parameter level: Positive integer value analogous to the amount of beams in 
     graphical representation.
     
     - returns: Initialized Subdivision structure
     */
    public init(level: Int) {
        self = Int(pow(2.0, (Double(level) + 2.0)))
    }
    
    /**
     - returns: `true` if `Subdivision` is a power-of-two. Otherwise `false`.
     */
    public var isValid: Bool { return self.isPowerOfTwo }
}
