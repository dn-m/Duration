//
//  MetricalDurationNode.swift
//  Duration
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation
import TreeTools

/// Tree structure with MetricalDuration value.
public class MetricalDurationNode: Node, MetricalDurationSpanning {
    
    // MARK: - Instance Properties
    
    /**
     - warning: Not yet implemented!
     
     `MetricalDurationInterval` of `MetricalDurationNode`.
     */
    public var interval: MetricalDurationInterval = MetricalDurationInterval.zero
    
    public class func metricalDurationNode(with: MetricalDuration)
        -> RigidMetricalDurationNode?
    {
        return nil
    }
}