//
//  BreathPresenterTests.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class BreathPresenterTests: XCTestCase {
    
    enum Constants {
        static let animationInterval: TimeInterval = 0.1
    }
    
    var sut: BreathPresenter!
    var view: MockBreathViewInput!
    var interactor: MockBreathInteractorInput!t
    
    let mockedAnimationPhases: [AnimationPhase] = [
        AnimationPhase(type: .exhale, duration: 0.1, color: "#FF00FF"),
        AnimationPhase(type: .hold, duration: 0.2, color: "#00FFFF"),
        AnimationPhase(type: .inhale, duration: 0.3, color: "#FFFF00")
    ]
    
    override func setUp() {
        super.setUp()
        view = MockBreathViewInput()
        interactor = MockBreathInteractorInput()
        sut = BreathPresenter(
            animations: mockedAnimationPhases,
            totalRemainingTimeCountdown: Countdown(
                duration: mockedAnimationPhases.duration,
                interval: Constants.animationInterval
            )
        )
        sut.view = view
        sut.interactor = interactor
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        sut = nil
    }
    
    func test_viewIsReady_setIdleState() {
        XCTAssertTrue(view.animationTypeMockValues.isEmpty)
        XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty)
        XCTAssertTrue(view.animationColorMockValue.isEmpty)
        
        sut.viewIsReady()
        
        XCTAssertTrue(view.animationTypeMockValues.isEmpty == false)
        XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty)
        XCTAssertTrue(view.animationColorMockValue.isEmpty == false)
    }
    
    func test_didTapOnSquaredView_performTransitionAnimation() {
        XCTAssertTrue(interactor.performTransitionAnimationMockValues.isEmpty)
        XCTAssertTrue(interactor.executedAnimationsMockValues.isEmpty)
        
        sut.didTapOnSquaredView()
        
        XCTAssertTrue(interactor.performTransitionAnimationMockValues.isEmpty == false)
        XCTAssertTrue(interactor.executedAnimationsMockValues.isEmpty)
    }
    
    func test_didPerformTransition_setTransitionState() {
        XCTAssertTrue(view.animationTypeMockValues.isEmpty)
        XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty)
        XCTAssertTrue(view.animationColorMockValue.isEmpty)
        
        let mockedScale: CGFloat = 0.5
        let mockedDuration: TimeInterval = 0.1
        
        sut.didPerformTransition(duration: mockedDuration, scale: mockedScale)
        
        XCTAssertTrue(view.animationTypeMockValues.isEmpty)
        //XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty) // FIXME: should be false after change viewState to .transition
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty == false)
        XCTAssertTrue(view.animationColorMockValue.isEmpty == false)
    }
    
    func test_willExecuteAnimationPhases_interactor_executeAnimationPhases() {
        sut.willExecuteAnimationPhases()
        
        XCTAssertEqual(self.mockedAnimationPhases, interactor.executedAnimationsMockValues)
    }
    
    func test_willExecuteAnimationPhases_afterExecutingAllAnimations() {
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        
        let animationPhasesTotalIntervalsCount = Int(mockedAnimationPhases.duration / Constants.animationInterval)
        let animationPhasesTotalIntervalsExpectation = XCTestExpectation(description: "AnimationPhasesTotalIntervals Expectation")
        animationPhasesTotalIntervalsExpectation.expectedFulfillmentCount = animationPhasesTotalIntervalsCount + 1
        
        view.allAnimationsRemainingTimeObserver = { _ in
            animationPhasesTotalIntervalsExpectation.fulfill()
        }
        
        sut.willExecuteAnimationPhases()
        
        wait(for: [animationPhasesTotalIntervalsExpectation], timeout: mockedAnimationPhases.duration)
    }
    
    func test_didExecuteAnimationPhase_setAnimationPhaseState_withSingleAnimation() {
        XCTAssertTrue(view.animationTypeMockValues.isEmpty)
        XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty)
        XCTAssertTrue(view.animationColorMockValue.isEmpty)
        
        for animation in mockedAnimationPhases {
            sut.didExecuteAnimationPhase(animation)
        }
        
        XCTAssertTrue(view.animationTypeMockValues.isEmpty == false)
        XCTAssertEqual(view.animationTypeMockValues.count, 3)
        
        XCTAssertTrue(view.animationRemainingTimeMockValues.isEmpty == false)
        XCTAssertEqual(view.animationRemainingTimeMockValues.count, 3)
        
        XCTAssertTrue(view.allAnimationsRemainingTimeMockValues.isEmpty)
        
        XCTAssertTrue(view.animationScaleFactorMockValues.isEmpty == false)
        XCTAssertEqual(
            view.animationScaleFactorMockValues.count, 2,
            "Exhale/Inhale animation types made view transformation, hold type doesn't change."
        )
        
        XCTAssertTrue(view.animationColorMockValue.isEmpty == false)
        XCTAssertEqual(view.animationColorMockValue.count, 3)
    }
    
    func test_didFinishExecuteAllAnimations_setTransitionState() {
        XCTAssertTrue(interactor.performTransitionAnimationMockValues.isEmpty)
        XCTAssertTrue(interactor.executedAnimationsMockValues.isEmpty)
        
        sut.didFinishExecuteAllAnimations()
        
        XCTAssertTrue(interactor.performTransitionAnimationMockValues.isEmpty == false)
        XCTAssertTrue(interactor.executedAnimationsMockValues.isEmpty)
    }
    
}
