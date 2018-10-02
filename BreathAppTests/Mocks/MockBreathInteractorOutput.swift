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
    
    func didPerformTransition(duration: TimeInterval, scale: CGFloat) {
        didPerformTransitionValues.append((duration: duration, scale: scale))
    }
    
    func willExecuteAnimationPhases() {
        willExecuteAnimationPhasesValue = true
    }
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        executedAnimationPhasesMockValues.append(animation)
    }
    
    func didFinishExecuteAllAnimations() {
        didFinishExecuteAllAnimationsValue = true
    }
    
}