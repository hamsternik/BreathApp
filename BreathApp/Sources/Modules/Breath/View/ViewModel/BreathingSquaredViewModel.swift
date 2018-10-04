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
    
    private var remainingTimeFormatter: AnyStringFormatter<TimeInterval> = AnyStringFormatter(CountdownTimeFormatter())
    
    init(
        animationTypeText: String?,
        remainingTime: TimeInterval?,
        scaleFactor: CGFloat?,
        backgroundColor: UIColor?,
        remainingTimeFormatter: AnyStringFormatter<TimeInterval> = AnyStringFormatter(CountdownTimeFormatter())
    ) {
        self.animationTypeText = animationTypeText
        self.remainingTime = remainingTime
        self.scaleFactor = scaleFactor
        self.backgroundColor = backgroundColor
        self.remainingTimeFormatter = remainingTimeFormatter
    }
    
    private func applyRemainingTime(_ value: TimeInterval, on view: BreathViewInput) {
        Countdown(duration: value).fire { [remainingTimeFormatter] remainingTime in
            let remainingTimeText = remainingTimeFormatter.format(from: remainingTime)
            view.setAnimationRemainingTime(remainingTimeText)
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
