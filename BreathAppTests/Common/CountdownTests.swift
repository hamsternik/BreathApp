//
//  CountdownTests.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class CountdownTests: XCTestCase {
    
    struct CountdownTestModel {
        let duration: TimeInterval
        let interval: TimeInterval
        let bound: TimeInterval
    }
    
    var sut: Countdown?
    
    /// - Test Countdown instance and check the correctness of calculated remaining time and expected number of calls before invalidation.
    func test_countdownFire_withoutCancellation() {
        let testModel = CountdownTestModel(duration: 0.5, interval: 0.05, bound: 0.0)
        sut = Countdown(duration: testModel.duration, interval: testModel.interval)
        
        let expectation = XCTestExpectation(description: "Fire the Countdown. Test the full workflow, without cancellation.")
        expectation.expectedFulfillmentCount = Int(testModel.duration / testModel.interval)
        
        sut?.fire(bound: testModel.bound) { (remainingTime) in
            XCTAssertLessThanOrEqual(remainingTime, testModel.duration, "Remaining time should be equal or less than initial duration value.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_countdownFire_WithCancelation() {
        let testModel = CountdownTestModel(duration: 0.5, interval: 0.05, bound: 0.0)
        sut = Countdown(duration: testModel.duration, interval: testModel.interval)
        
        let expectation = XCTestExpectation(description: "Fire the Countdown. Test the workflow partially, with next cancellation.")
        let totalExpectedFulfillmentCount = Int(testModel.duration / testModel.interval) // Should be 10
        let actualExpectedFulfillmentCount = totalExpectedFulfillmentCount / 4
        expectation.expectedFulfillmentCount = actualExpectedFulfillmentCount
        
        let countdownAction = sut?.fire(bound: testModel.bound) { (remainingTime) in
            XCTAssertLessThanOrEqual(remainingTime, testModel.duration, "Remaining time should be equal or less than initial duration value.")
            expectation.fulfill()
        }
        
        let expectedTimeToCancell: TimeInterval = testModel.interval * TimeInterval(actualExpectedFulfillmentCount)
        DispatchQueue.main.asyncAfter(deadline: .now() + expectedTimeToCancell) {
            countdownAction?.perform()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
