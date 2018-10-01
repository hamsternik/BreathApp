//
//  BreathingSquaredViewModel.swift
//  BreathApp
//
//  Created by Nikita Khomitsevich on 9/26/18.
//  Copyright © 2018 Nikita Khomitsevich. All rights reserved.
//

import UIKit

struct BreathingSquaredViewModel {
    
    var animationTypeText: String?
    var remainingTime: TimeInterval?
    var scaleFactor: CGFloat?
    var backgroundColor: UIColor?
   
    private func applyRemainingTime(_ value: TimeInterval, on view: BreathViewInput) {
        Countdown(duration: value).fire { remainingTime in
            view.setAnimationRemainingTime("00:0\(Int(remainingTime))")
        }
    }
    
}

extension BreathingSquaredViewModel {
    
    func apply(on view: BreathViewInput) {
        view.setAnimationType(animationTypeText)
        remainingTime.map { applyRemainingTime($0, on: view) }
        scaleFactor.map { view.setAnimationScaleFactor($0, duration: remainingTime ?? 0.0) }
        backgroundColor.map { view.setAnimationColor($0) }
    }
    
}
