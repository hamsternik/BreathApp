//
//  MockBreathPresenter.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class MockBreathPresenter: BreathViewOutput, BreathInteractorOutput {
    
    typealias VoidObserver = () -> Void
    typealias TransitionObserver = (TimeInterval, CGFloat) -> Void
    typealias AnimationPhaseObserver = (AnimationPhase) -> Void
    
    private(set) var viewIsReadyObserver: VoidObserver = {}
    private(set) var didTapOnSquaredViewObserver: VoidObserver = {}
    
    private(set) var didPerformTransitionObserver: TransitionObserver = { _,_  in }
    private(set) var willExecuteAnimationPhasesObserver: VoidObserver = {}
    
    private(set) var didExecuteAnimationPhaseObserver: AnimationPhaseObserver = { _ in }
    private(set) var didFinishExecuteAllAnimationsObserver: VoidObserver = {}
    
    // MARK: - BreathViewOutput
    
    func viewIsReady() {
        viewIsReadyObserver()
    }
    
    func didTapOnSquaredView() {
        didTapOnSquaredViewObserver()
    }
    
    // MARK: - BreathInteractorOutput
    
    func didPerformTransition(duration: TimeInterval, scale: CGFloat) {
        didPerformTransitionObserver(duration, scale)
    }
    
    func willExecuteAnimationPhases() {
        willExecuteAnimationPhasesObserver()
    }
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        didExecuteAnimationPhaseObserver(animation)
    }
    
    func didFinishExecuteAllAnimations() {
        didFinishExecuteAllAnimationsObserver()
    }
    
}
