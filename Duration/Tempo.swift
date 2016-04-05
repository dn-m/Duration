//
//  Tempo.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

public struct Tempo {
    
    public let subdivision: Subdivision
    public let value: Float
    
    public init(subdivision: Subdivision, value: Float) {
        self.subdivision = subdivision
        self.value = value
    }
}