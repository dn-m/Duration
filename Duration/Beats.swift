//
//  Beats.swift
//  Duration
//
//  Created by James Bean on 3/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Beats in a `MetricalDuration`.
 */
public struct Beats {
    
    // MARK: - Instance Properties
    
    /// Amount of Beats
    public let amount: Int
    
    // MARK: - Initializers
    
    /**
     Create a Beats with amount.
     
     - parameter amount: Amount of Beats
     
     - returns: Initialized Beats structure
     */
    public init(amount: Int) {
        self.amount = amount
    }
}

// MARK: - Equatable
extension Beats: Equatable { }

/**
 Check equality of two Beats Values.
 
 - returns: `true` of Beats amounts are equivalent, otherwise `false`.
 */
public func == (lhs: Beats, rhs: Beats) -> Bool {
    return lhs.amount == rhs.amount
}

// MARK: - Comparable
extension Beats: Comparable { }

/**
 Check if Beats is less than another Beats.
 

 - returns: `true` if Beats is less than another. Otherwise, `false`.
 */
public func < (lhs: Beats, rhs: Beats) -> Bool {
    return lhs.amount < rhs.amount
}

public func * (lhs: Beats, rhs: Int) -> Beats {
    return Beats(amount: lhs.amount * rhs)
}

public func * (lhs: Beats, rhs: Float) -> Beats? {
    guard (Float(lhs.amount) * rhs).isInteger else { return nil }
    return Beats(amount: Int(Float(lhs.amount) * abs(rhs)))
}

public func / (lhs: Beats, rhs: Int) -> Beats? {
    guard (Float(lhs.amount) / Float(rhs)).isInteger else { return nil }
    return Beats(amount: Int(Float(lhs.amount / abs(rhs))))
}

public func / (lhs: Beats, rhs: Float) -> Beats? {
    guard (Float(lhs.amount) / rhs).isInteger else { return nil }
    return Beats(amount: Int(Float(lhs.amount) / abs(rhs)))
}

// MARK: - CustomStringConvertible
extension Beats: CustomStringConvertible {
    public var description: String { return "Beats: (amount: \(amount))" }
}