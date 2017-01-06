//
//  Metronome.swift
//  Clock
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation

open class Metronome
{
    var interval: TimeInterval
    
    let closure : (()->())
    
    fileprivate var timer: Timer?
    
    public init(interval: TimeInterval, closure: @escaping ()->())
    {
        self.interval = interval
        self.closure = closure
    }
    
    open func start()
    {
        guard !isRunning else { return }
        
        scheduleTimer()
    }

    open func stop()
    {
        unscheduleTimer()
    }
    
    open var isRunning : Bool { return timer?.isValid == true }
    
    private func unscheduleTimer()
    {
        guard timer != nil else { return }
        
        timer?.invalidate()
        timer = nil
    }
    
    private func scheduleTimer()
    {
        unscheduleTimer()
        
        let timer = Timer(timeInterval: interval, repeats: true)
        { (timer) in
        
            DispatchQueue.main.async(execute: self.closure)
        }
        
        RunLoop.main.add(timer, forMode: .commonModes)
        
        self.timer = timer
    }
    
    deinit
    {
        unscheduleTimer()
    }
}
