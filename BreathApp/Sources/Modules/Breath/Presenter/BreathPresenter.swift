//
//  BreathPresenter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/2/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation
import CoreGraphics

class BreathPresenter {
    
    enum Constants {
        static let startTransitionScalingDuration: TimeInterval = 0.75
        static let endTransitionScalingDuration: TimeInterval = 0.0
        static let startTransitionScaleFactor: CGFloat = 0.75
        static let endTransitionScaleFactor: CGFloat = 1.0
    }
    
    weak var view: BreathViewInput!
    var interactor: BreathInteractorInput!
    
    var state: BreathViewState = .idle {
        didSet {
            BreathingSquaredViewModelBuilder().build(for: state).apply(on: view)
        }
    }
    
    private var animations = [AnimationPhase]()
    private var brethingAnimationFinished: Bool = false
    
    init(animations: [AnimationPhase]) {
        self.animations = animations
    }
    
}

extension BreathPresenter: BreathViewOutput {
    
    func viewIsReady() {
        BreathingSquaredViewModelBuilder().build(for: state).apply(on: view)
    }
    
    func didTapOnSquaredView() {
        brethingAnimationFinished = false
        interactor.performTransition(
            with: Constants.startTransitionScalingDuration,
            scale: Constants.startTransitionScaleFactor
        )
    }
    
}

extension BreathPresenter: BreathInteractorOutput {
    
    func didPerformTransition(duration: TimeInterval, scale: CGFloat) {
        state = .transition(duration: duration, scale: scale)
    }
    
    func willExecuteAnimationPhases() {
        guard brethingAnimationFinished == false else {
            state = .idle
            return
        }
        
        interactor.execute(animations: animations)
        let countdown = Countdown(duration: animations.duration)
        countdown.fire { [view] (remainingTime) in
            // FIXME: Should implement specific `formatter` and convert raw value into user-friendly time format
            var remainingTimeString = (floor(remainingTime) >= 10) ? "Remaining 00:" : "Remaining 00:0"
            remainingTimeString += "\(Int(remainingTime))"
            view?.setAllAnimationsRemainingTime(remainingTimeString)
        }
    }
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        state = .animation(phase: animation)
    }
    
    func didFinishExecuteAllAnimations() {
        brethingAnimationFinished = true
        interactor.performTransition(
            with: Constants.endTransitionScalingDuration,
            scale: Constants.endTransitionScaleFactor
        )
    }
    
}
