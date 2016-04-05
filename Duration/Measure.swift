//
//  Measure.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/// Model of Measure of musical information
public class Measure: MetricalDurationSpanning {

    public var number: Int = 0
    public var metricalDurationInterval = MetricalDurationInterval.zero
}