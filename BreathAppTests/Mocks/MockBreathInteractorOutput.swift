//
//  MockBreathInteractorOutput.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class MockBreathInteractorOutput: BreathInteractorOutput {
    
    private(set) var executedAnimationPhasesMockValues: [AnimationPhase] = []
    private(set) var didFinishExecuteAllAnimationsValue: Bool = false
    private(set) var didPerformTransitionValues: [(duration: TimeInterval, scale: CGFloat)] = []
    private(set) var willExecuteAnimationPhasesValue: Bool = false
    
    var didPerformTransitionObserver: (_ duration: TimeInterval, _ scale: CGFloat) -> Void = { _,_ in }
    var willExecuteAnimationPhasesObserver: () -> Void = { }
    
    var didExecuteAnimationPhaseObserver: (_ animation: AnimationPhase) -> Void = { _ in }
    var didFinishExecuteAllAnimationsObserver: () -> Void = {}
    
    
    func didPerformTransition(duration: TimeInterval, scale: CGFloat) {
        didPerformTransitionValues.append((duration: duration, scale: scale))
        didPerformTransitionObserver(duration, scale)
    }
    
    func willExecuteAnimationPhases() {
        willExecuteAnimationPhasesValue = true
        willExecuteAnimationPhasesObserver()
    }
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        executedAnimationPhasesMockValues.append(animation)
        didExecuteAnimationPhaseObserver(animation)
    }
    
    func didFinishExecuteAllAnimations() {
        didFinishExecuteAllAnimationsValue = true
        didFinishExecuteAllAnimationsObserver()
    }
    
}
