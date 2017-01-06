//
//  Stopwatch.swift
//  Clock
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation

open class Stopwatch
{
    public init() {}
    
    private var started: Date?
    private var accumulatedElapsed: TimeInterval = 0
    private var currentElapsed: TimeInterval { return -(started?.timeIntervalSinceNow ?? 0) }
    
    public var elapsed: TimeInterval
    {
        return accumulatedElapsed + currentElapsed
    }
    
    public var isRunning: Bool
    {
        return started != nil
    }
    
    /**
     Resets the stopwatch
     - returns: **true** if the stopwatch was indeed reset by this call, **false** if he stopwatch was already reset
     */
    @discardableResult
    open func reset() -> Bool
    {
        guard isResettable else { return false }
        
        started = nil
        accumulatedElapsed = 0
        
        return true
    }
    
    /** Tells whether the stopwatch can be reset; i.e. elapsed > 0 */
    open var isResettable: Bool
    {
        return elapsed > 0
    }
    
    /**
     (re)starts the stopwatch
     - returns: **true** if the stopwatch was indeed started by this call, **false** if he stopwatch was already running
     */
    @discardableResult
    open func start() -> Bool
    {
        guard !isRunning else { return false }
        
        started = Date()
        
        return true
    }
    
    /**
     Stop/pauses the stopwatch
     - returns: elapsed time if the stopwatch was indeed stopped by this call, nil if he stopwatch was already stopped
     */
    @discardableResult
    open func stop() -> TimeInterval?
    {
        guard isRunning else { return nil }
        
        accumulatedElapsed += currentElapsed
        started = nil
        
        return elapsed
    }
}
