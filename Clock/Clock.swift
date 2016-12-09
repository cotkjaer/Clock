//
//  Clock.swift
//  Clock
//
//  Created by Christian Otkjær on 09/12/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation
import Calendar

private let debugFormatter: DateFormatter =
    {
        let df = DateFormatter()
        df.timeStyle = .full
        df.dateStyle = .none
        return df
}()

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
        
        if let date = calendar.next(unit)
        {
            debugPrint("nextdate for \(debugFormatter.string(from: Date())) -> \(debugFormatter.string(from: date))")
            
            let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(Clock.handleTimer), userInfo: nil, repeats: false)
            
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
            
            self.timer = timer
        }
        else
        {
            debugPrint("Could not create next date")
        }
    }
    
    @objc fileprivate func handleTimer()
    {
        scheduleTimer()
        closure()
    }
}
