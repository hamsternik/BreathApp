//
//  BreathInteractorInterface.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import Foundation
import CoreGraphics

protocol BreathInteractorInput {
    
    var output: BreathInteractorOutput! { get set }
    
    func performTransition(with duration: TimeInterval, scale: CGFloat)
    func execute(animations: [AnimationPhase])
    
}

protocol BreathInteractorOutput: class {
    
    func didPerformTransition(duration: TimeInterval, scale: CGFloat)
    func willExecuteAnimationPhases()
    func didExecuteAnimationPhase(_ animation: AnimationPhase)
    func didFinishExecuteAllAnimations()
    
}
