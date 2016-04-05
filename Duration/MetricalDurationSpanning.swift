//
//  MetricalDurationSpanning.swift
//  Duration
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import IntervalTools

public protocol MetricalDurationSpanning {

    var metricalDurationInterval: MetricalDurationInterval { get }
    
    static func elementsFrom<T: MetricalDurationSpanning>(array: [T],
        withinInterval metricalDurationInterval: MetricalDurationInterval
    ) -> [T]
}

extension MetricalDurationSpanning {
    
    public static func elementsFrom<T: MetricalDurationSpanning>(array: [T],
        withinInterval metricalDurationInterval: MetricalDurationInterval
    ) -> [T]
    {
        let allowedRelationships: IntervalRelationship = [
            .Equals, .Contains, .Starts, .StartedBy, .Finishes, .FinishedBy
        ]
        
        return array.filter {
            allowedRelationships.contains(
                metricalDurationInterval.relationship(with: $0.metricalDurationInterval)
            )
        }
    }
}