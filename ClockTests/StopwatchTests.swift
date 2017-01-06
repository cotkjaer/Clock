//
//  StopwatchTests.swift
//  Clock
//
//  Created by Christian Otkjær on 05/01/17.
//  Copyright © 2017 Silverback IT. All rights reserved.
//

import XCTest
@testable import Clock

class StopwatchTests: XCTestCase
{
    func test_start()
    {
        let stopwatch = Stopwatch()
        
        XCTAssertFalse(stopwatch.isRunning)
        
        XCTAssertEqual(stopwatch.elapsed, 0)
        
        XCTAssertTrue(stopwatch.start())
        
        XCTAssertTrue(stopwatch.isRunning)
        
        XCTAssertGreaterThan(stopwatch.elapsed, 0)
        
        XCTAssertFalse(stopwatch.start())
        
        let stoppedTime = stopwatch.stop()
        
        XCTAssertNotNil(stoppedTime)
        
        XCTAssertNil(stopwatch.stop())
        
        XCTAssertFalse(stopwatch.isRunning)
        
        let elapsed = stopwatch.elapsed
        
        XCTAssertGreaterThan(elapsed, 0)
        
        XCTAssertEqual(elapsed, stoppedTime)
        XCTAssertEqual(elapsed, stopwatch.elapsed)
        
        XCTAssertTrue(stopwatch.start())

        XCTAssertGreaterThan(stopwatch.elapsed, elapsed)
    }
}
