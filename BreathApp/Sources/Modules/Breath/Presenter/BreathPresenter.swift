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
    
    private var animations: [AnimationPhase]
    private var totalRemainingTimeCountdown: Countdown
    private var countdownTimeFormatter: AnyStringFormatter<TimeInterval>
    
    private var brethingAnimationFinished: Bool = false
    private var totalRemainingTimeMapper: (String?) -> String? = { (remainingTime: String?) -> String? in
        return remainingTime.map { "Remaining\n " + $0 }
    }
    
    init(
        animations: [AnimationPhase],
        totalRemainingTimeCountdown: Countdown,
        countdownTimeFormatter: AnyStringFormatter<TimeInterval> = AnyStringFormatter(CountdownTimeFormatter())
    ) {
        self.animations = animations
        self.totalRemainingTimeCountdown = totalRemainingTimeCountdown
        self.countdownTimeFormatter = countdownTimeFormatter
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
        view.setAllAnimationsRemainingTime(nil)
    }
    
    func willExecuteAnimationPhases() {
        guard brethingAnimationFinished == false else {
            state = .idle
            return
        }
        
        interactor.execute(animations: animations)
        totalRemainingTimeCountdown.fire { [view, countdownTimeFormatter, totalRemainingTimeMapper] (remainingTime) in
            let remainingTimeText = totalRemainingTimeMapper(countdownTimeFormatter.format(from: remainingTime))
            view?.setAllAnimationsRemainingTime(remainingTimeText)
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
