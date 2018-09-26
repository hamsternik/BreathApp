//
//  BreathViewModel.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit

struct BreathViewModel {
    
    var animationType: String?
    var animationRemainingTime: String?
    var totalRemainingTime: String?
    var scaleFactor: CGFloat?
    var backgroundColor: UIColor
    
}

extension BreathViewModel {
    
    func apply(on view: BreathViewInput, duration: TimeInterval) {
        view.setAnimationType(animationType)
        view.setAnimationRemainingTime(animationRemainingTime)
        view.setAllAnimationsRemainingTime(totalRemainingTime)
        scaleFactor.map { view.setAnimationScaleFactor($0, duration: duration) }
        view.setAnimationColor(backgroundColor)
    }
    
}
