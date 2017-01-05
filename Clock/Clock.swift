//
//  Clock.swift
//  Clock
//
//  Created by Christian Otkjær on 09/12/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation
import Calendar

open class Clock
{
    fileprivate let calendar = Calendar.autoupdatingCurrent
    
    let unit: Calendar.Component
    
    let closure : (()->())
    
    fileprivate var timer: Timer?
    
    public init(unit: Calendar.Component, closure: @escaping ()->())
    {
        self.unit = unit
        self.closure = closure
    }
    
    deinit
    {
        timer?.invalidate()
    }
    
    open var running : Bool { return timer?.isValid == true }
    
    open func start()
    {
        scheduleTimer()
    }
    
    open func stop()
    {
        unscheduleTimer()
    }
    
    func unscheduleTimer()
    {
        timer?.invalidate()
        timer = nil
    }
    
    func scheduleTimer()
    {
        unscheduleTimer()
        
        guard let date = calendar.next(unit) else
        {
            debugPrint("Could not create next date")
            return
        }
        
        let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(Clock.handleTimer), userInfo: nil, repeats: false)
        
        RunLoop.main.add(timer, forMode: .commonModes)
        
        self.timer = timer
    }
    
    @objc fileprivate func handleTimer()
    {
        scheduleTimer()
        
        DispatchQueue.main.async(execute: closure)
    }
}
