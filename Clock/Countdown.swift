//
//  Countdown.swift
//  Clock
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import Foundation

open class Countdown: NSObject
{
    public var delegate: CountdownDelegate?
    
    public let seconds: Int
    public private(set) var countedSeconds: Int = 0
    
    public init(seconds: Int)
    {
        self.seconds = seconds
        super.init()
    }
    
    open func canStart() -> Bool
    {
        return !isFinished && !isRunning
    }
    
    open func start()
    {
        scheduleTimer()
    }
    
    open func canStop() -> Bool
    {
        return isRunning
    }
    
    open func stop()
    {
        unscheduleTimer()
    }
    
    open func canReset() -> Bool
    {
        return countedSeconds > 0
    }
    
    open func reset()
    {
        stop()
        
        guard countedSeconds > 0 else { return }
        
        countedSeconds = 0
        tell { $0.countdownDidReset(self) }
    }
    
    open var isRunning : Bool { return timer?.isValid == true }
    
    open var isFinished : Bool { return countedSeconds >= seconds }
    
    deinit
    {
        unscheduleTimer()
    }
    
    private func tell(closure: @escaping (CountdownDelegate)->())
    {
        guard let delegate = delegate else { return }
        
        DispatchQueue.main.async { closure(delegate) }
    }
    
    private var timer: Timer?

    private func unscheduleTimer()
    {
        guard timer != nil else { return }
        
        timer?.invalidate()
        timer = nil
        
        tell(closure: { $0.countdownDidStop(self) })
    }
    
    private func scheduleTimer()
    {
        unscheduleTimer()
        
        let timer = Timer(timeInterval: 1, repeats: true) { (timer) in
            
            self.countedSeconds += 1
            
            self.tell(closure: { $0.countdownDidTick(self) })
            
            if self.countedSeconds >= self.seconds
            {
                self.stop()
            }
        }
        
        RunLoop.main.add(timer, forMode: .commonModes)
        
        self.timer = timer
        
        tell(closure: { $0.countdownDidStart(self) })
    }
}

public protocol CountdownDelegate
{
    func countdownDidStart(_ countdown: Countdown)
    func countdownDidStop(_ countdown: Countdown)
    func countdownDidTick(_ countdown: Countdown)
    func countdownDidReset(_ countdown: Countdown)
}
