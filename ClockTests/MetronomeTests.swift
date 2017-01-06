//
//  MetronomeTests.swift
//  Clock
//
//  Created by Christian Otkjær on 06/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import XCTest
@testable import Clock

class MetronomeTests: XCTestCase
{
    func test_metronome()
    {
        let e = expectation(description: "ok")
        
        var tickCounter = 0
        let interval: TimeInterval = 0.1
        
        let tickCounterTarget: Int = Int(1/interval) + 1
        
        let metronome = Metronome(interval: interval)
        {
            tickCounter += 1
            
            if tickCounter == tickCounterTarget
            {
                e.fulfill()
            }
        }
        
        metronome.start()
        
        waitForExpectations(timeout: interval * Double(tickCounterTarget + 1))
        {
            (e) in
            if let e = e
            {
                XCTFail(e.localizedDescription)
            }
        }
    }
}
