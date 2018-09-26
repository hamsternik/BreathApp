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
        animations.forEach { animation in
            // FIXME: shouldn't run all animations one-by-one, must be another mechanism
            // to run each animation phase regarding with the previous animations sum duration.
            Timer.scheduledTimer(withTimeInterval: animation.duration, repeats: true) { [unowned self] _ in
                self.output.didExecuteAnimationPhase(animation)
            }
        }
    }
    
}
