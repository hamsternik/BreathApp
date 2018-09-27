//
//  BreathInteractorInterface.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation

protocol BreathInteractorInput {
    
    var output: BreathInteractorOutput! { get set }
    
    func execute(animations: [AnimationPhase])
    
}

protocol BreathInteractorOutput: class {
    
    func didExecuteAnimationPhase(_ animation: AnimationPhase)
    func didFinishExecuteAllAnimations()
    
}
