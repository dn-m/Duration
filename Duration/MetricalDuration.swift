//
//  MetricalDuration.swift
//  Duration
//
//  Created by James Bean on 3/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import ArithmeticTools

/**
 Musical Duration defined by a `Beats` value and `Subdivision` value.
 */
public struct MetricalDuration {

    // MARK: - Type Properties
    
    /// No-width MetricalDuration
    public static let Zero = MetricalDuration(0,8)!
    
    // MARK: - Type Methods
    
    /**
    Get the total Subdivision value of MetricalDuration. Is analogous to the amount of beams
        in graphical representation.
    
    >`(6,32) -> Subdivision(value: 16, level: 2)`
    
    - note: Ultimately, implement in Beams renderer, along with augmentation dot
    
    - parameter beats:       Beats
    - parameter subdivision: Subdivision
    
    - returns: Total Subdivision
    */
    public static func totalSubdivision(withBeats beats: Beats,
        andSubdivision subdivision: Subdivision
    ) -> Subdivision
    {
        if beats.amount <= 1 { return subdivision }
        let limit = beats.amount.isPowerOfTwo ? 1 : 2
        var level = subdivision.level + 1
        var amountBeats = closestPowerOfTwo(under: beats.amount)!
        while amountBeats >= limit {
            amountBeats /= 2
            level -= 1
        }
        return Subdivision(level: level)
    }
    
    // MARK: - Instance Properties
    
    /// `Beats` value of MetricalDuration
    public let beats: Beats
    
    /// `Subdivision` value of MetricalDuration
    public let subdivision: Subdivision
    
    /// Scale of MetricalDuration
    public let scale: Float
    
    /// Total Subdivision value of MetricalDuration (analogous to amount of Beams rendered)
    public let totalSubdivision: Subdivision
    
    /// Float value
    public var floatValue: Float {
        return (Float(beats.amount) / Float(subdivision.value)) * scale
    }
    
    /// If `MetricalDuration` is represented in its most reduced form.
    public var isReduced: Bool { return beats.amount.isOdd }
    
    // MARK: - Initializers
    
    /**
    Create a MetricalDuration.
    
    - parameter beats:       `Beats` value
    - parameter subdivision: `Subdivision` value
    - parameter scale:        Scale
    */
    public init(beats: Beats, subdivision: Subdivision, scale: Float = 1.0) {
        self.beats = beats
        self.subdivision = subdivision
        self.scale = scale
        self.totalSubdivision = MetricalDuration.totalSubdivision(withBeats: beats,
            andSubdivision: subdivision
        )
    }
    
    /**
     Create a MetricalDuration.
     
     - parameter beatsAmount:      Amount of `Beats`
     - parameter subdivisionValue: Value of `Subdivision`
     - parameter scale:            Scale
     */
    public init?(_ beatsAmount: Int, _ subdivisionValue: Int, scale: Float = 1.0) {
        guard let s = Subdivision(value: subdivisionValue) else { return nil }
        self.init(
            beats: Beats(amount: beatsAmount),
            subdivision: s
        )
    }
    
    /**
     Create a MetricalDuration with a floatValue. 
     
     >`MetricalDuration(floatValue: 1.0) // MetricalDuration(1,8)!`
     >`MetricalDuration(floatValue: 1.25) // MetricalDuration(5,32)!`
     
     - parameter floatValue: Float value of Metrical Duration
     - parameter scale:      Scale
     */
    public init(floatValue: Float, scale: Float = 1.0) {
        guard floatValue != 0 else { self.init(0, 8)!; return }
        var subdivisionValue: Int = 8
        var beatsAsFloat = floatValue
        while !beatsAsFloat.isInteger {
            beatsAsFloat *= 2
            subdivisionValue *= 2
        }
        self.init(Int(beatsAsFloat), subdivisionValue)!
    }
    
    // TODO: init?(string)
    
    // MARK: - Instance Methods
    
    /**
    Get the most reduced, logically equivalent form of MetricalDuration.
    
    >`MetricalDuration(10,64)!.reduce() // MetricalDuration(5,32)!`
    
    - returns: Most reduced form of MetricalDuration
    */
    public func reduce() -> MetricalDuration {
        guard !self.isReduced else { return self }
        var b = beats.amount
        var s = subdivision.value
        while !b.isOdd {
            b /= 2
            s /= 2
        }
        return MetricalDuration(b,s)!
    }
    
    /**
     Get a MetricalDuration that is logically equivalent, though is represented with a given
        Beats value.
     
     - parameter newBeats: Beats value to normalize new MetricalDuration
     
     - returns: Logically equivalent MetricalDuration, represented with given Beats value
     */
    public func respell(with newBeats: Beats) -> MetricalDuration? {
        guard beats != newBeats else { return self }
        let ratio = Float(newBeats.amount) / Float(beats.amount)
        guard let newSubdivision = subdivision * ratio else { return nil }
        return MetricalDuration(beats: newBeats, subdivision: newSubdivision)
    }
    
    /**
     Get a MetricalDuration that is logically equivalent, though is represented with a given
        Subdivision value.
     
     - parameter newSubdivision: Subdivision value with which to respell MetricalDuration
     
     - returns: Logically equivalent MetricalDuration, represented with given Subdivision value
     */
    public func respell(with newSubdivision: Subdivision) -> MetricalDuration? {
        guard subdivision != newSubdivision else { return self }
        let ratio = Float(newSubdivision.value) / Float(subdivision.value)
        guard let newBeats = beats * ratio else { return nil }
        return MetricalDuration(beats: newBeats, subdivision: newSubdivision)
    }
}

// MARK: - Equatable
extension MetricalDuration: Equatable { }

/**
 Check equality of two MetricalDuration Values.
 
 - returns: True of MetricalDuration amounts are equivalent, otherwise false.
 */
public func == (lhs: MetricalDuration, rhs: MetricalDuration) -> Bool {
    return lhs.floatValue == rhs.floatValue
}

// MARK: - Comparable
extension MetricalDuration: Comparable { }

/**
 Check if MetricalDuration is less than another Beats.
 
 - returns: True if MetricalDuration is less than another. Otherwise, false.
 */
public func < (lhs: MetricalDuration, rhs: MetricalDuration) -> Bool {
    return lhs.floatValue < rhs.floatValue
}

/**
 - TODO: Integrate `scale`
 
 - returns: Sum of two `MetricalDuration` values
 */
public func + (lhs: MetricalDuration, rhs: MetricalDuration) -> MetricalDuration {
    let (a,b) = reduce(lhs, rhs)
    return MetricalDuration(a.beats.amount + b.beats.amount, a.subdivision.value)!
}

/**
 - TODO: Integrate `scale`
 
 - returns: Difference of two `MetricalDuration` values
 */
public func - (lhs: MetricalDuration, rhs: MetricalDuration) -> MetricalDuration {
    let (a,b) = reduce(lhs, rhs)
    return MetricalDuration(a.beats.amount - b.beats.amount, a.subdivision.value)!
}

/**
 Make `MetricalDuration` values that are logically equivalent to those given, represented with
    equivalent `Subdivision` values.
 
 - returns: MetricalDurations with equivalent `Subdivision` values
 */
public func level(a: MetricalDuration, _ b: MetricalDuration)
    -> (MetricalDuration, MetricalDuration)
{
    guard !areLevel(a,b) else { return (a,b) }
    let a_n = a.beats.amount * b.subdivision.value
    let b_n = b.beats.amount * a.subdivision.value
    let d = b.subdivision.value * a.subdivision.value
    let newA = MetricalDuration(a_n, d)!
    let newB = MetricalDuration(b_n, d)!
    return (newA, newB)
}

/**
 - returns: `true` if Subdivision values are equivalent. Otherwise `false`.
 */
public func areLevel(a: MetricalDuration, _ b: MetricalDuration) -> Bool {
    return a.subdivision == b.subdivision
}

/**
 Make `MetricalDuration` values that are logically equivalent to those given, represented in 
    their mututally most reduced forms.
 
 - returns: MetricalDurations in mutually most reduced forms.
 */
public func reduce(a: MetricalDuration, _ b: MetricalDuration)
    -> (MetricalDuration, MetricalDuration)
{
    let (a,b) = level(a,b)
    var a_n = a.beats.amount
    var a_d = a.subdivision.value
    var b_n = b.beats.amount
    var b_d = b.subdivision.value
    while a_n.isEven && b_n.isEven {
        a_n /= 2
        a_d /= 2
        b_n /= 2
        b_d /= 2
    }
    let newA = MetricalDuration(a_n, a_d)!
    let newB = MetricalDuration(b_n, b_d)!
    return (newA, newB)
}

/**
 - returns: `true` if either `MetricalDuration` is in its most reduced representation.
    Otherwise `false`.
 */
public func areReduced(a: MetricalDuration, _ b: MetricalDuration) -> Bool {
    return a.beats.amount.isOdd || b.beats.amount.isOdd
}

// MARK: - CustomStringConvertible
extension MetricalDuration: CustomStringConvertible {
    
    public var description: String {
        var result: String = beats.amount == 0
            ? "Duration.Zero"
            : "\(beats.amount)/\(subdivision.value)"
        if scale != 1.0 { result += " * \(scale)" }
        return result
    }
}
