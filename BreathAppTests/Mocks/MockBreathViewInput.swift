//
//  MockBreathViewInput.swift
//  BreathAppTests
//
//  Created by Nikita Khomitsevich on 9/28/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import XCTest
@testable import BreathApp

class MockBreathViewInput: BreathViewInput {
    
    private(set) var animationTypeMockValues: [String?] = []
    private(set) var animationRemainingTimeMockValue: [String?] = []
    private(set) var allAnimationsRemainingTimeMockValues: [String?] = []
    private(set) var animationScaleFactorMockValues: [(scale: CGFloat, duration: TimeInterval)] = []
    private(set) var animationColorMockValue: [UIColor] = []
    
    var output: BreathViewOutput!
    
    func setAnimationType(_ animationType: String?) {
        animationTypeMockValues.append(animationType)
    }
    
    func setAnimationRemainingTime(_ remainingTime: String?) {
        animationRemainingTimeMockValue.append(remainingTime)
    }
    
    func setAllAnimationsRemainingTime(_ remainingTime: String?) {
        allAnimationsRemainingTimeMockValues.append(remainingTime)
    }
    
    func setAnimationScaleFactor(_ scale: CGFloat, duration: TimeInterval) {
        animationScaleFactorMockValues.append((scale, duration))
    }
    
    func setAnimationColor(_ color: UIColor) {
        animationColorMockValue.append(color)
    }
    
}
