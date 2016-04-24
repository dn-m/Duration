//
//  Tempo.swift
//  Duration
//
//  Created by James Bean on 4/5/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Foundation

/**
 Tempo with a value and a Subdivision.
 */
public struct Tempo {
    
    /// Metronome marking of tempo in beats per minute.
    public let value: Float
    
    /// Subdivision value of Tempo.
    public let subdivision: Subdivision

    /**
     Create a Tempo.
     */
    public init(value: Float, subdivision: Subdivision = 8) {
        self.subdivision = subdivision
        self.value = value
    }
}
