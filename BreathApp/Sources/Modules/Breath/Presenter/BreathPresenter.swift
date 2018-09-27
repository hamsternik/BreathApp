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
        // FIXME: Bad idea to set up `duration` from the static constant
        static let idleStateFirstScaleDuration: TimeInterval = 0.0
        static let idleStateLastScaleDuration: TimeInterval = 0.5
    }
    
    weak var view: BreathViewInput!
    var interactor: BreathInteractorInput!
    
    var state: BreathViewState = .idle(duration: Constants.idleStateFirstScaleDuration)
    
    private var animations = [AnimationPhase]()
    
    init(animations: [AnimationPhase]) {
        self.animations = animations
    }
    
}

extension BreathPresenter: BreathViewOutput {
    
    func viewIsReady() {
        state.viewModel.apply(on: view, duration: Constants.idleStateFirstScaleDuration)
    }
    
    func didTapOnSquaredView() {
        interactor.execute(animations: animations)
        let countdown = Countdown(duration: animations.duration)
        countdown.fire { [view] (remainingTime) in
            // FIXME: Should implement specific `formatter` and convert raw value into user-friendly time format
            let remainingTimeString = "\(remainingTime)"
            view?.setAllAnimationsRemainingTime(remainingTimeString)
        }
    }
    
}

extension BreathPresenter: BreathInteractorOutput {
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase) {
        state = .active(phase: animation)
        state.viewModel.apply(on: view, duration: animation.duration)
    }
    
    func didFinishExecuteAllAnimations() {
        state = .idle(duration: Constants.idleStateLastScaleDuration)
        state.viewModel.apply(on: view, duration: Constants.idleStateLastScaleDuration)
    }
    
}
