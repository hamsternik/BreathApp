//
//  BreathInteractorTests.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class BreathInteractorTests: XCTestCase {
    
    enum Constants {
        static let tresholdTimeInterval: TimeInterval = 0.01
    }
    
    var sut: BreathInteractorInput!
    var output: MockBreathInteractorOutput!
    
    override func setUp() {
        super.setUp()
        sut = BreathInteractor()
        output = MockBreathInteractorOutput()
        sut.output = output
    }
    
    override func tearDown() {
        super.tearDown()
        output = nil
        sut = nil
    }
    
    func test_performTransition() {
        let didPerformTransitionExpectation = XCTestExpectation(description: "Transition animation was performed successfully")
        let willExecuteAnimationPhasesExpectation = XCTestExpectation(description: "Animations execution was prepared successfully")
        
        let mockedScale: CGFloat = 0.5
        let mockedDuration: TimeInterval = 0.1
        
        output.didPerformTransitionObserver = { (duration, scale) in
            XCTAssertEqual(mockedDuration, duration)
            XCTAssertEqual(mockedScale, scale)
            didPerformTransitionExpectation.fulfill()
        }
        
        output.willExecuteAnimationPhasesObserver = {
            willExecuteAnimationPhasesExpectation.fulfill()
        }
        
        sut.performTransition(with: mockedDuration, scale: mockedScale)
        
        wait(
            for: [didPerformTransitionExpectation, willExecuteAnimationPhasesExpectation],
            timeout: mockedDuration + Constants.tresholdTimeInterval
        )
    }
    
    func test_executeAnimations() {
        let didFinishExecuteAllAnimationsExpectation = XCTestExpectation(description: "All animations was executed successfully")
        let didExecuteExhaleAnimationPhaseExpectation = XCTestExpectation(description: "Exhale animation has been executed successfully")
        let didExecuteHoldAnimationPhaseExpectation = XCTestExpectation(description: "Hold animation has been executed successfully")
        let didExecuteInhaleAnimationPhaseExpectation = XCTestExpectation(description: "Inhale animation has been executed successfully")
        
        let mockedAnimationPhases: [AnimationPhase] = [
            AnimationPhase(type: .exhale, duration: 0.1, color: "#FF00FF"),
            AnimationPhase(type: .hold, duration: 0.2, color: "#00FFFF"),
            AnimationPhase(type: .inhale, duration: 0.3, color: "#FFFF00")
        ]
        
        output.didFinishExecuteAllAnimationsObserver = {
            didFinishExecuteAllAnimationsExpectation.fulfill()
        }
        
        output.didExecuteAnimationPhaseObserver = { animation in
            // XCTAssertTrue(mockedAnimationPhases.contains(animation), "\(animation.type.rawValue) animation got from mockedAnimationPhases.")

            switch animation.type {
            case .exhale: didExecuteExhaleAnimationPhaseExpectation.fulfill()
            case .hold: didExecuteHoldAnimationPhaseExpectation.fulfill()
            case .inhale: didExecuteInhaleAnimationPhaseExpectation.fulfill()
            }
        }
        
        sut.execute(animations: mockedAnimationPhases)
        
        wait(
            for: [
                didFinishExecuteAllAnimationsExpectation,
                didExecuteExhaleAnimationPhaseExpectation,
                didExecuteHoldAnimationPhaseExpectation,
                didExecuteInhaleAnimationPhaseExpectation
            ],
            timeout: mockedAnimationPhases.duration + Constants.tresholdTimeInterval
        )
    }
}
