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
    
    private(set) var animationTypeMockValues: [String] = []
    private(set) var animationRemainingTimeMockValues: [String] = []
    private(set) var allAnimationsRemainingTimeMockValues: [String] = []
    private(set) var animationScaleFactorMockValues: [(scale: CGFloat, duration: TimeInterval)] = []
    private(set) var animationColorMockValue: [UIColor] = []
    
    var allAnimationsRemainingTimeObserver: (String?) -> Void = { _ in }
    
    var output: BreathViewOutput!
    
    func setAnimationType(_ animationType: String?) {
        animationType.map { animationTypeMockValues.append($0) }
    }
    
    func setAnimationRemainingTime(_ remainingTime: String?) {
        remainingTime.map { animationRemainingTimeMockValues.append($0) }
    }
    
    func setAllAnimationsRemainingTime(_ remainingTime: String?) {
        remainingTime.map { allAnimationsRemainingTimeMockValues.append($0) }
        allAnimationsRemainingTimeObserver(remainingTime)
    }
    
    func setAnimationScaleFactor(_ scale: CGFloat, duration: TimeInterval) {
        animationScaleFactorMockValues.append((scale, duration))
    }
    
    func setAnimationColor(_ color: UIColor) {
        animationColorMockValue.append(color)
    }
    
}
