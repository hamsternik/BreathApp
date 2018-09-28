//
//  MockBreathInteractorInput.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class MockBreathInteractorInput: BreathInteractorInput {
    
    private(set) var executedAnimationsMockValues: [AnimationPhase] = []
    
    var output: BreathInteractorOutput!
    
    func execute(animations: [AnimationPhase]) {
        executedAnimationsMockValues.append(contentsOf: animations)
    }
    
    
}
