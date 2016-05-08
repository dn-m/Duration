//
//  Beats.swift
//  Duration
//
//  Created by James Bean on 3/7/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public struct Beats: IntegerLiteralConvertible {
    
    public typealias IntegerLiteralType = Int

    internal let value: Int
    
    public init(integerLiteral value: Int) {
        self.value = value
    }
    
    public init(_ int: Int) {
        self.init(integerLiteral: int)
    }
    
    public init(_ float: Float) {
        self.value = Int(float)
    }
}

public func + (lhs: Beats, rhs: Beats) -> Beats {
    return Beats(lhs.value + rhs.value)
}

public func - (lhs: Beats, rhs: Beats) -> Beats {
    return Beats(lhs.value - rhs.value)
}

extension Beats: Comparable { }

public func == (lhs: Beats, rhs: Beats) -> Bool {
    return lhs.value == rhs.value
}

public func < (lhs: Beats, rhs: Beats) -> Bool {
    return lhs.value < rhs.value
}

extension Float {
    
    public init(_ beats: Beats) {
        self = Float(beats.value)
    }
}

