//
//  TempoInterpolation.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public struct TempoInterpolation: MetricalDurationSpanning {
    
    public let metricalDurationInterval: MetricalDurationInterval
    public let start: Tempo
    public let stop: Tempo
    
    
    // TODO: public let curve: (Float, Float) -> Float
}