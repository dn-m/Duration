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
public struct Subdivision {
    
    // MARK: - Type Methods
    
    /**
     Check if a value is a valid Subdivision value.
    
     >`isValid(value: 32) // true`
     >`isValid(value: 42) // false`
     
     - parameter value: Value to be checked
     
     - returns: If the value is a valid Subdivision value
     */
    public static func isValid(value value: Int) -> Bool {
        return value.isPowerOfTwo
    }
    
    /**
    Get the Subdivision level from a Subdivision value.
    
    >`levelFrom(16) -> 2`
    
    - parameter value: Subdivision value
     
    - returns: Subdivision level
    */
    public static func levelFrom(value: Int) -> Int? {
        guard Subdivision.isValid(value: value) else { return nil }
        return Int(log(Double(value))/log(2)) - 2
    }
    
    /**
     Get the Subdivision value from a Subdivision level.
     
     - parameter level: Subdivision level
     
     - returns: Subdivision value
     */
    public static func valueFrom(level: Int) -> Int {
        return Int(pow(2.0, (Double(level) + 2.0)))
    }
    
    // MARK: - Instance Properties
    
    /// Power-of-two value of the subdivision (e.g., 4, 8, 16, 32, etc.).
    public let value: Int
    
    /// Positive integer value analogous to the amount of beams in graphical representation.
    public let level: Int
    
    // MARK: - Initializers
    
    /**
    Create a Subvisiion with a value.
    
    - parameter value: Power-of-two value of the subdivision (e.g., 4, 8, 16, 32, etc.)
    
    - returns: Initialized Subdivision structure, if possible. Returns `nil` if value 
        is not greater than 0, or a power-of-two
    */
    public init?(value: Int) {
        guard let l = Subdivision.levelFrom(value) else { return nil }
        self.level = l
        self.value = value
    }
    
    /**
     Create a Subdivision with a level.
     
     - parameter level: Positive integer value analogous to the amount of beams in 
     graphical representation.
     
     - returns: Initialized Subdivision structure
     */
    public init(level: Int) {
        self.level = level
        self.value = Subdivision.valueFrom(level)
    }
}

// MARK: - Equatable
extension Subdivision: Equatable { }

/**
 Check equality of two Subdivision Values.
 
 - returns: True of Subdivision levels are equivalent, otherwise false.
 */
public func == (lhs: Subdivision, rhs: Subdivision) -> Bool {
    return lhs.level == rhs.level
}

// MARK: - Comparable
extension Subdivision: Comparable { }

/**
 Check if Subdivision is less than another Subdivision.
 
 - returns: True if Subdivision is less than another. Otherwise, false.
 */
public func < (lhs: Subdivision, rhs: Subdivision) -> Bool {
    return lhs.level < rhs.level
}

/**
 Get the product of a Subdivision and an Int.
 
 >`Subdivision(value: 8)! * 4 // Subdivision(value: 32)!
 */
public func * (lhs: Subdivision, rhs: Int) -> Subdivision? {
    return Subdivision(value: lhs.value * abs(rhs))
}

/**
 - returns: Product of `Subdivision` value and `Float`, if valid `Subdivision`. Otherwise `nil`
 
 >`(Subdivision(value: 32)! * 2.0)! // Subdivision(value: 64)!`
 >`(Subdivision(value: 32)! * 0.25)! // Subdivision(value: 8)!`
 >`Subdivision(value: 16)! * 0.618 // nil`
 */
public func * (lhs: Subdivision, rhs: Float) -> Subdivision? {
    guard (Float(lhs.value) * rhs).isInteger else { return nil }
    return Subdivision(value: Int(Float(lhs.value) * abs(rhs)))
}

/**
 Get the quotient of a `Subdivision` and an `Int`, if possible.
 
 - returns: Quotient of a Subdivision and an Int.
 */
public func / (lhs: Subdivision, rhs: Int) -> Subdivision? {
    guard (Float(lhs.value) / Float(rhs)).isInteger else { return nil }
    return Subdivision(value: lhs.value / abs(rhs))
}

/**
 - returns: Quotient of `Subdivision` and `Float`, if valid `Subdivision`. Otherwise `nil`
 
 >`(Subdivision(value: 32)! / 2.0)! // Subdivision(value: 16)!`
 >`(Subdivision(value: 32)! / 0.5)! // Subdivision(value: 64)!`
 >`Subdivision(value: 32) / 0.618 // nil`
 */
public func / (lhs: Subdivision, rhs: Float) -> Subdivision? {
    guard (Float(lhs.value) / rhs).isInteger else { return nil }
    return Subdivision(value: Int(Float(lhs.value) / abs(rhs)))
}

// MARK: - CustomStringConvertible
extension Subdivision: CustomStringConvertible {
    public var description: String { return "Subdivision: (value: \(value), level: \(level))" }
}


