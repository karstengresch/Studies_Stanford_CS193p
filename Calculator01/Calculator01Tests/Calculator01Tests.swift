//
//  Calculator01Tests.swift
//  Calculator01Tests
//
//  Created by Karsten Gresch on 16.07.15.
//  Copyright (c) 2015 Closure One. All rights reserved.
//

import UIKit
import XCTest

class Calculator01Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        var brain = CalculatorBrain()
        brain.pushOperand(1.0)
        brain.pushOperand(100.0)
        if let sum = brain.performOperation("+")
        {
            assert(sum == 101.0, "Expected result was 101.0")
        }
        else {
          assert(false, "Expected result was not 101.0")
      }
      
      
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
