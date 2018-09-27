//
//  BreathInteractor.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation


class BreathInteractor {
    
    weak var output: BreathInteractorOutput!
    
}

extension BreathInteractor: BreathInteractorInput {
    
    func execute(animations: [AnimationPhase]) {
        guard animations.count > 0 else {
            output.didFinishExecuteAllAnimations()
            return
        }
        
        var animations = animations
        let currentAnimation = animations.removeFirst()
        output.didExecuteAnimationPhase(currentAnimation)
        Timer.scheduledTimer(withTimeInterval: currentAnimation.duration, repeats: false) { [weak self] _ in
            self?.execute(animations: animations)
        }
    }
    
}
