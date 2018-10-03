//
//  BreathViewTests.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class BreathViewTests: XCTestCase {
    
    var sut: BreathViewController!
    var output: MockBreathViewOutput!
    
    override func setUp() {
        super.setUp()
        sut = BreathViewController()
        output = MockBreathViewOutput()
        sut.output = output
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        output = nil
        sut = nil
        super.tearDown()
    }
    
    func test_setAnimationType_withUpdate_animationTypeLabel_text() {
        XCTAssertEqual(output.viewIsReadyValue, true)
        
        let animationTypeLabel = UILabel()
        sut.animationTypeLabel = animationTypeLabel
        let expectation = XCTestExpectation(description: "Expectation: set up the animation type (main thread).")
        
        let animationTypeString = "Unknown type"
        sut.setAnimationType(animationTypeString)
        
        onMain {
            XCTAssertEqual(self.sut.animationTypeLabel.text, animationTypeString)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_setAnimationRemainingTime_withUpdate_animationRemainingTimeLabel_text() {
        XCTAssertEqual(output.viewIsReadyValue, true)
        
        let remainingTimeLabel = UILabel()
        sut.animationRemainingTimeLabel = remainingTimeLabel
        let expectation = XCTestExpectation(description: "Expectation: set up the animation remaining time (main thread).")
        
        let remainingTimeString = "60 minutes"
        sut.setAnimationRemainingTime(remainingTimeString)
        
        onMain {
            XCTAssertEqual(self.sut.animationRemainingTimeLabel.text, remainingTimeString)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_setAllAnimationsRemainingTime_withUpdate_animationRemainingTimeLabel_text() {
        XCTAssertEqual(output.viewIsReadyValue, true)
        
        let totalAnimationRemainingTimeLabel = UILabel()
        sut.totalAnimationRemainingTimeLabel = totalAnimationRemainingTimeLabel
        let expectation = XCTestExpectation(description: "Expectation: set up the total remaining time (main thread).")
        
        let totalRemainingTimeString = "60 minutes"
        sut.setAllAnimationsRemainingTime(totalRemainingTimeString)
        
        onMain {
            XCTAssertEqual(self.sut.totalAnimationRemainingTimeLabel.text, totalRemainingTimeString)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_setAnimationScaleFactor_withUpdate_breathingSquaredView_transform() {
        XCTAssertEqual(output.viewIsReadyValue, true)
        
        let breathingSquaredView = UIView()
        sut.breathingSquaredView = breathingSquaredView
        let expectation = XCTestExpectation(description: "Expectation: set up the animated scaling on view (main thread).")
        
        let scaleFactor: CGFloat = 0.75
        let scaledMatrix = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        sut.setAnimationScaleFactor(scaleFactor, duration: 0.0)
        
        onMain {
            XCTAssertEqual(self.sut.breathingSquaredView.transform, scaledMatrix)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_setAnimationColor_withUpdate_breathingSquaredView_backgroundColor() {
        XCTAssertEqual(output.viewIsReadyValue, true)
        
        let breathingSquaredView = UIView()
        sut.breathingSquaredView = breathingSquaredView
        let expectation = XCTestExpectation(description: "Expectation: set up the animated view background color (main thread).")
        
        let greenColor: UIColor = .green
        sut.setAnimationColor(greenColor)
        
        onMain {
            XCTAssertEqual(self.sut.breathingSquaredView.backgroundColor, greenColor)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
