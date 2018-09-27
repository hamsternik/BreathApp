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
        animationType.map { view.setAnimationType($0) }
        if animationRemainingTime != nil {
            Countdown(duration: duration).fire { (remainingTime) in
                view.setAnimationRemainingTime("00:0\(Int(remainingTime))")
            }
        }
        
        totalRemainingTime.map { view.setAllAnimationsRemainingTime($0) }
        scaleFactor.map { view.setAnimationScaleFactor($0, duration: duration) }
        view.setAnimationColor(backgroundColor)
    }
    
}

extension BreathViewModel {
    
    static let idleBreathViewStateViewModel = BreathViewModel(
        animationType: "tap here".uppercased(),
        animationRemainingTime: "to breath".uppercased(),
        totalRemainingTime: nil,
        scaleFactor: 0.75,
        backgroundColor: UIColor("#7A83F2", defaultColor: .white)
    )
    
}
