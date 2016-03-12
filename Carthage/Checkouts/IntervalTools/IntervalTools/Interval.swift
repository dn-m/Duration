//
//  Interval.swift
//  IntervalTools
//
//  Created by James Bean on 3/9/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public protocol Interval {
    typealias T = Comparable
    var start: T { get }
    var stop: T { get }
    var span: T { get }
    func relationshipWith(interval: Self) -> IntervalRelationship
}