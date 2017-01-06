//
//  ClockTests.swift
//  ClockTests
//
//  Created by Christian Otkjær on 09/12/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import XCTest
@testable import Clock

class ClockTests: XCTestCase
{
    func test_second()
    {
        var runCounter = 0
        let target = 3
        
        let expectation = self.expectation(description: "Got to \(target)")
        
        let clock = Clock(unit: .second) { _ in
            
            runCounter += 1
            
            if runCounter > target { expectation.fulfill() }
        }
        
        XCTAssertEqual(runCounter, 0)
        XCTAssertEqual(clock.isRunning, false)
        
        clock.start()
        
        XCTAssertEqual(runCounter, 0)
        XCTAssertEqual(clock.isRunning, true)
        
        waitForExpectations(timeout: Double(1 + target)) { e in
            
            if let error = e
            {
                XCTFail("Error: \(error.localizedDescription)")
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
