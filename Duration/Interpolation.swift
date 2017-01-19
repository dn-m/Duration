//
//  Interpolation.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public protocol Interpolation {
    
    associatedtype T
    
    var start: T { get }
    var stop: T { get }
}
