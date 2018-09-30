//
//  BreathPresenter.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 7/2/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

class BreathPresenter {
    
    enum Constants {
        static let transitionScalingDuration: TimeInterval = 0.5
    }
    
    weak var view: BreathViewInput!
    var interactor: BreathInteractorInput!
    
    var state: BreathViewState = .idle {
        didSet {
            BreathingSquaredViewModelBuilder().build(for: state).apply(on: view)
        }
    }
    
    private var animations = [AnimationPhase]()
    
    init(animations: [AnimationPhase]) {
        self.animations = animations
    }
    
}

extension BreathPresenter: BreathViewOutput {
    
    func viewIsReady() {
        BreathingSquaredViewModelBuilder().build(for: state).apply(on: view)
    }
    
    func didTapOnSquaredView() {
        interactor.performTransition(with: Constants.transitionScalingDuration)
    }
    
}

extension BreathPresenter: BreathInteractorOutput {
    
    func didPerformTransition(with duration: TimeInterval) {
        state = .transition(duration: duration)
        
        interactor.execute(animations: animations)
        let countdown = Countdown(duration: animations.duration)
        countdown.fire { [view] (remainingTime) in
            // FIXME: Should implement specific `formatter` and convert raw value into user-friendly time format
            let remainingTimeString = "Remaining 00:0\(Int(remainingTime))"
            view?.setAllAnimationsRemainingTime(remainingTimeString)
        }
    }
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        state = .animation(phase: animation)
    }
    
    func didFinishExecuteAllAnimations() {
        state = .transition(duration: Constants.transitionScalingDuration)
    }
    
}
