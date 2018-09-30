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
    var remainingTime: (value: TimeInterval, text: String?)
    var scaleFactor: CGFloat?
    var backgroundColor: UIColor?
   
    private func applyRemainingTimeText(_ text: String?, on view: BreathViewInput) {
        Countdown(duration: remainingTime.value).fire { remainingTime in
            view.setAnimationRemainingTime(text)
        }
    }
    
}

extension BreathingSquaredViewModel {
    
    func apply(on view: BreathViewInput) {
        view.setAnimationType(animationTypeText)
        applyRemainingTimeText(remainingTime.text, on: view)
        scaleFactor.map { view.setAnimationScaleFactor($0, duration: remainingTime.value) }
        backgroundColor.map { view.setAnimationColor($0) }
    }
    
}
